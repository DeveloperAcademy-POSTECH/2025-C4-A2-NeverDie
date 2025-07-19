//
//  HealthKitService.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import Foundation
import HealthKit
import Combine

@MainActor
class HealthKitService: ObservableObject {
    private let healthStore = HKHealthStore()
    
    @Published var isAuthorized = false
    @Published var stepCount: Double = 0
    @Published var activeEnergyBurned: Double = 0
    @Published var heartRate: Double = 0
    @Published var sleepHours: Double = 0
    
    // HealthKit에서 읽을 데이터 타입들
    private let readTypes: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
    ]
    
    init() {
        checkHealthDataAvailability()
    }
    
    // MARK: - 권한 확인 및 요청
    
    private func checkHealthDataAvailability() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit이 이 기기에서 사용할 수 없습니다.")
            return
        }
    }
    
    func requestHealthKitPermissions() async {
        do {
            try await healthStore.requestAuthorization(toShare: [], read: readTypes)
            await updateAuthorizationStatus()
        } catch {
            print("HealthKit 권한 요청 실패: \(error.localizedDescription)")
        }
    }
    
    private func updateAuthorizationStatus() async {
        let stepCountStatus = healthStore.authorizationStatus(for: HKObjectType.quantityType(forIdentifier: .stepCount)!)
        isAuthorized = stepCountStatus == .sharingAuthorized
    }
    
    // MARK: - 데이터 가져오기
    
    func fetchTodayHealthData() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchStepCount() }
            group.addTask { await self.fetchActiveEnergyBurned() }
            group.addTask { await self.fetchLatestHeartRate() }
            group.addTask { await self.fetchSleepData() }
        }
    }
    
    // 걸음수 가져오기
    private func fetchStepCount() async {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        let predicate = createTodayPredicate()
        let query = HKStatisticsQuery(
            quantityType: stepCountType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { [weak self] _, result, error in
            guard let self = self, let result = result, error == nil else {
                print("걸음수 조회 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
                return
            }
            
            Task { @MainActor in
                let steps = result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
                self.stepCount = steps
            }
        }
        
        healthStore.execute(query)
    }
    
    // 활성 에너지 소모량 가져오기
    private func fetchActiveEnergyBurned() async {
        guard let energyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        
        let predicate = createTodayPredicate()
        let query = HKStatisticsQuery(
            quantityType: energyType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { [weak self] _, result, error in
            guard let self = self, let result = result, error == nil else {
                print("활성 에너지 조회 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
                return
            }
            
            Task { @MainActor in
                let energy = result.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) ?? 0
                self.activeEnergyBurned = energy
            }
        }
        
        healthStore.execute(query)
    }
    
    // 최신 심박수 가져오기
    private func fetchLatestHeartRate() async {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: heartRateType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [sortDescriptor]
        ) { [weak self] _, samples, error in
            guard let self = self, let samples = samples as? [HKQuantitySample], let latestSample = samples.first, error == nil else {
                print("심박수 조회 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
                return
            }
            
            Task { @MainActor in
                let heartRate = latestSample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                self.heartRate = heartRate
            }
        }
        
        healthStore.execute(query)
    }
    
    // 수면 데이터 가져오기 (오늘)
    private func fetchSleepData() async {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        let predicate = createTodayPredicate()
        let query = HKSampleQuery(
            sampleType: sleepType,
            predicate: predicate,
            limit: HKObjectQueryNoLimit,
            sortDescriptors: nil
        ) { [weak self] _, samples, error in
            guard let self = self, let samples = samples as? [HKCategorySample], error == nil else {
                print("수면 데이터 조회 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
                return
            }
            
            Task { @MainActor in
                let totalSleepTime = samples.reduce(0.0) { total, sample in
                    let duration = sample.endDate.timeIntervalSince(sample.startDate)
                    return total + duration
                }
                
                self.sleepHours = totalSleepTime / 3600 // 초를 시간으로 변환
            }
        }
        
        healthStore.execute(query)
    }
    
    // MARK: - Helper Methods
    
    private func createTodayPredicate() -> NSPredicate {
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
    }
    
    // 특정 날짜 범위 프레디케이트 생성
    private func createDateRangePredicate(from startDate: Date, to endDate: Date) -> NSPredicate {
        return HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
    }
    
    // MARK: - 주간/월간 데이터 가져오기
    
    func fetchWeeklyStepCount() async -> [Double] {
        return await fetchWeeklyData(for: .stepCount, unit: HKUnit.count())
    }
    
    func fetchWeeklyActiveEnergy() async -> [Double] {
        return await fetchWeeklyData(for: .activeEnergyBurned, unit: HKUnit.kilocalorie())
    }
    
    private func fetchWeeklyData(for identifier: HKQuantityTypeIdentifier, unit: HKUnit) async -> [Double] {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            return Array(repeating: 0, count: 7)
        }
        
        let calendar = Calendar.current
        let now = Date()
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: now)?.start ?? now
        
        return await withCheckedContinuation { continuation in
            var weeklyData: [Double] = Array(repeating: 0, count: 7)
            let group = DispatchGroup()
            
            for dayOffset in 0..<7 {
                group.enter()
                
                let dayStart = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)!
                let dayEnd = calendar.date(byAdding: .day, value: 1, to: dayStart)!
                
                let predicate = HKQuery.predicateForSamples(withStart: dayStart, end: dayEnd, options: .strictStartDate)
                let query = HKStatisticsQuery(
                    quantityType: quantityType,
                    quantitySamplePredicate: predicate,
                    options: .cumulativeSum
                ) { _, result, error in
                    defer { group.leave() }
                    
                    guard let result = result, error == nil else { return }
                    let value = result.sumQuantity()?.doubleValue(for: unit) ?? 0
                    weeklyData[dayOffset] = value
                }
                
                healthStore.execute(query)
            }
            
            group.notify(queue: .main) {
                continuation.resume(returning: weeklyData)
            }
        }
    }
} 
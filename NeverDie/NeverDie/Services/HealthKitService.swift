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
    
    // HealthKit에서 읽을 데이터 타입들
    private let readTypes: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: .stepCount)!
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
        await fetchStepCount()
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
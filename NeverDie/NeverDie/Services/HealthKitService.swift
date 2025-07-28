//
//  HealthKitService.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import Foundation
import HealthKit
import Combine
import SwiftData

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
            try await Task.sleep(nanoseconds: 500_000_000) // 0.5초
            await updateAuthorizationStatus()
        } catch {
            print("❌ HealthKit 권한 요청 실패: \(error.localizedDescription)")
        }
    }
    
    private func updateAuthorizationStatus() async {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        
        let stepCountStatus = healthStore.authorizationStatus(for: stepCountType)
        await MainActor.run {
            isAuthorized = stepCountStatus == .sharingAuthorized
        }
    }
    
    /// 권한 상태만 확인 (요청하지 않음)
    func checkAuthorizationStatus() async {
        await updateAuthorizationStatus()
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
    
    // MARK: - HealthKit to WalkingSession 변환
    
    /// 전체 기간의 HealthKit 데이터를 가져와서 WalkingSession으로 변환 (MVP: 최근 90일)
    func fetchAndConvertAllWalkingSessions(modelContext: ModelContext) async {
        let dateRange = calculateFullSyncDateRange()
        
        var currentDate = dateRange.start
        while currentDate <= dateRange.end {
            await fetchAndConvertDailyWalkingSessions(for: currentDate, modelContext: modelContext)
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
    }
    
    /// 전체 동기화할 날짜 범위 계산 (MVP: 최근 90일)
    private func calculateFullSyncDateRange() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // MVP: 최근 90일만 처리 (나중에 iPhone 설치일부터로 확장 가능)
        let startDate = calendar.date(byAdding: .day, value: -90, to: today) ?? today
        
        return (start: startDate, end: today)
    }
    
    /// 특정 날짜의 시간별 걸음 수 데이터를 가져와서 WalkingSession으로 변환
    func fetchAndConvertDailyWalkingSessions(for date: Date, modelContext: ModelContext) async {
        let hourlyStepData = await fetchHourlyStepData(for: date)
        let walkingSessions = convertToWalkingSessions(hourlyStepData: hourlyStepData, date: date)
        await saveWalkingSessions(walkingSessions, to: modelContext)
    }
    
    /// 특정 날짜의 시간별 걸음 수 데이터 가져오기
    private func fetchHourlyStepData(for date: Date) async -> [Int: Int] {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return [:]
        }
        
        let calendar = Calendar.current
        var hourlyData: [Int: Int] = [:]
        
        return await withCheckedContinuation { continuation in
            let group = DispatchGroup()
            
            // 24시간 각각에 대해 데이터 가져오기
            for hour in 0..<24 {
                group.enter()
                
                let hourStart = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: date)!
                let hourEnd = calendar.date(byAdding: .hour, value: 1, to: hourStart)!
                
                let predicate = HKQuery.predicateForSamples(withStart: hourStart, end: hourEnd, options: .strictStartDate)
                let query = HKStatisticsQuery(
                    quantityType: stepCountType,
                    quantitySamplePredicate: predicate,
                    options: .cumulativeSum
                ) { _, result, error in
                    defer { group.leave() }
                    
                    guard let result = result, error == nil else { return }
                    let steps = Int(result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0)
                    hourlyData[hour] = steps
                }
                
                healthStore.execute(query)
            }
            
            group.notify(queue: .main) {
                continuation.resume(returning: hourlyData)
            }
        }
    }
    
    /// 시간별 걸음 수 데이터를 WalkingSession 배열로 변환
    private func convertToWalkingSessions(hourlyStepData: [Int: Int], date: Date) -> [WalkingSession] {
        var sessions: [WalkingSession] = []
        
        for (hour, stepCount) in hourlyStepData {
            // 걸음 수가 0보다 큰 경우에만 세션 생성
            guard stepCount > 0 else { continue }
            
            let distance = estimateDistance(from: stepCount)
            let calories = estimateCalories(from: stepCount)
            
            let session = WalkingSession(
                date: date,
                hour: hour,
                distance: distance,
                stepCount: stepCount,
                calories: calories
            )
            
            sessions.append(session)
        }
        
        return sessions
    }
    
    /// 걸음 수로부터 거리 추정 (미터)
    private func estimateDistance(from stepCount: Int) -> Double {
        // 평균 보폭을 70cm로 가정
        let averageStepLength: Double = 0.7 // 미터
        return Double(stepCount) * averageStepLength
    }
    
    /// 걸음 수로부터 칼로리 추정 (kcal)
    private func estimateCalories(from stepCount: Int) -> Double {
        // 걸음당 평균 0.04kcal 소모로 가정
        let caloriesPerStep: Double = 0.04
        return Double(stepCount) * caloriesPerStep
    }
    
    /// 특정 날짜와 시간의 기존 WalkingSession 찾기
    private func findExistingSession(date: Date, hour: Int, in modelContext: ModelContext) throws -> WalkingSession? {
        let allSessions = try modelContext.fetch(FetchDescriptor<WalkingSession>())
        return allSessions.first { session in
            Calendar.current.isDate(session.date, inSameDayAs: date) && session.hour == hour
        }
    }
    
    /// WalkingSession 배열을 SwiftData에 저장
    private func saveWalkingSessions(_ sessions: [WalkingSession], to modelContext: ModelContext) async {
        await MainActor.run {
            for session in sessions {
                // 같은 날짜, 같은 시간의 기존 데이터가 있는지 확인
                do {
                    let existingSession = try findExistingSession(
                        date: session.date, 
                        hour: session.hour, 
                        in: modelContext
                    )
                    
                    if let existing = existingSession {
                        // 기존 세션 업데이트
                        existing.stepCount = session.stepCount
                        existing.distance = session.distance
                        existing.calories = session.calories
                    } else {
                        // 새 세션 삽입
                        modelContext.insert(session)
                    }
                } catch {
                    // 에러 처리
                }
            }
            
            // 변경사항 저장
            do {
                try modelContext.save()
            } catch {
                // 에러 처리
            }
        }
    }
    
    // MARK: - 테스트 및 디버깅 메서드
    
    /// 샘플 WalkingSession 데이터로 저장 테스트
    func testSaveWalkingSessions(modelContext: ModelContext) async {
        let today = Date()
        let sampleSessions = createSampleWalkingSessions(for: today)
        
        await saveWalkingSessions(sampleSessions, to: modelContext)
    }
    
    /// 테스트용 샘플 WalkingSession 생성
    private func createSampleWalkingSessions(for date: Date) -> [WalkingSession] {
        let sampleData: [(hour: Int, stepCount: Int)] = [
            (8, 1200),   // 오전 8시: 1200걸음
            (12, 800),   // 점심 12시: 800걸음
            (14, 1500),  // 오후 2시: 1500걸음
            (18, 2000),  // 오후 6시: 2000걸음 (퇴근)
            (20, 1000)   // 오후 8시: 1000걸음 (저녁산책)
        ]
        
        return sampleData.map { data in
            WalkingSession(
                date: date,
                hour: data.hour,
                distance: estimateDistance(from: data.stepCount),
                stepCount: data.stepCount,
                calories: estimateCalories(from: data.stepCount)
            )
        }
    }
    
    /// 특정 날짜의 저장된 WalkingSession 조회 및 출력
    func printStoredWalkingSessions(for date: Date, modelContext: ModelContext) {
        do {
            let allSessions = try modelContext.fetch(FetchDescriptor<WalkingSession>())
            let filteredSessions = allSessions.filter { session in
                Calendar.current.isDate(session.date, inSameDayAs: date)
            }.sorted { $0.hour < $1.hour }
            
            print("📊 \(date.formatted(date: .abbreviated, time: .omitted)) 저장된 데이터:")
            if filteredSessions.isEmpty {
                print("   데이터 없음")
            } else {
                for session in filteredSessions {
                    print("   \(session.formattedTimeSlot): \(session.stepCount)걸음, \(session.formattedDistance), \(session.formattedCalories)")
                }
            }
        } catch {
            
        }
    }
    
    /// 전체 저장된 WalkingSession 개수 확인
    func getTotalStoredSessionsCount(modelContext: ModelContext) -> Int {
        let descriptor = FetchDescriptor<WalkingSession>()
        
        do {
            let sessions = try modelContext.fetch(descriptor)
            return sessions.count
        } catch {
            return 0
        }
    }
    
    /// 모든 저장된 데이터 삭제 (테스트용)
    func clearAllWalkingSessions(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<WalkingSession>()
        
        do {
            let sessions = try modelContext.fetch(descriptor)
            for session in sessions {
                modelContext.delete(session)
            }
            try modelContext.save()
        } catch {
            
        }
    }
} 

//
//  ChartViewModel.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/22/25.
//

import Foundation
import HealthKit

@MainActor
class StepChartViewModel: ObservableObject {
    // 시간대별 걸음 수 데이터 (1시간 단위)
    @Published var hourlyStepData: [StepData] = []
    
    // 하루 총 걸음 수
    @Published var totalSteps: Int = 0
    
    // 하루 동안 저축된 수명 (분)
    @Published var totalSavedMinutes: Double = 0.0
    
    // 현재 날짜 (UI에서 날짜 표시에 사용)
    @Published var currentDate: Date = Date()
    
    // HealthKit 인스턴스
    private let healthStore = HKHealthStore()
    
    init() {
        loadMockData() // 더미데이터 삽입(테스트용)
    }
    
    // 더미 데이터 로딩 함수
    func loadMockData() {
        let mockData = (0..<24).map { hour in
            StepData(hour: hour, stepCount: Int.random(in: 0...1000))
        }
        
        self.hourlyStepData = mockData
        self.totalSteps = mockData.map { $0.stepCount }.reduce(0, +)
        self.totalSavedMinutes = Double(totalSteps) / 100.0
        self.currentDate = Date()
    }
    
    /// 오늘 하루의 걸음 수 데이터를 1시간 단위로 불러오기
    func fetchStepDataForToday() async {
        // HealthKit 사용 가능 여부 확인
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        // 걸음 수 타입 정의
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let calendar = Calendar.current
        let now = Date()
        
        // 오늘의 시작 시간 (00시)와 종료 시간 (익일 00시)
        guard let startOfDay = calendar.startOfDay(for: now) as Date?,
              let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)
        else { return }
        
        // 1시간 간격으로 통계를 수집
        let interval = DateComponents(hour: 1)
        
        // 오늘 하루 범위의 데이터만 쿼리
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay)
        
        // 통계 수집 쿼리 생성
        let query = HKStatisticsCollectionQuery(
            quantityType: stepType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum, // 걸음 수 누적합
            anchorDate: startOfDay,
            intervalComponents: interval
        )
        
        // 쿼리 결과를 처리하는 핸들러
        query.initialResultsHandler = { [weak self] _, results, _ in
            guard let self = self, let stats = results else { return }
            
            var stepData: [StepData] = []
            var totalSteps = 0
            
            // 각 시간대별 통계를 순회
            stats.enumerateStatistics(from: startOfDay, to: endOfDay) { stat, _ in
                // 걸음 수 추출
                let stepCount = stat.sumQuantity()?.doubleValue(for: .count()) ?? 0
                let hour = calendar.component(.hour, from: stat.startDate)
                
                let step = Int(stepCount)
                totalSteps += step
                
                // 시간대별 데이터 배열에 추가
                stepData.append(
                    StepData(hour: hour, stepCount: step)
                )
            }
            
            // 전체 걸음 수 기준으로 저축된 수명 계산 (100걸음 = 1분)
            let totalSaved = Double(totalSteps) / 100.0
            
            // UI 갱신은 메인 스레드에서 실행
            DispatchQueue.main.async {
                self.hourlyStepData = stepData
                self.totalSteps = totalSteps
                self.totalSavedMinutes = totalSaved
                self.currentDate = now
            }
        }
        
        // 쿼리 실행
        healthStore.execute(query)
    }
}

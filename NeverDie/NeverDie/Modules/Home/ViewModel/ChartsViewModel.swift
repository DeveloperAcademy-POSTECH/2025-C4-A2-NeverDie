//
//  ChartViewModel.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/22/25.
//

import Foundation
import HealthKit

@MainActor
class StepChartsViewModel: ObservableObject {
    @Published var firstRecordDate: Date? = Calendar.current.date(byAdding: .year, value: -2, to: Date()) // 예시
    
    // 날짜 데이터 사용
    @Published var currentDate: Date = Date()
    
    // 선택된 기간에 따른 걸음 수 데이터
    @Published var hourlyStepData: [StepData] = []
    @Published var weeklyStepData: [StepData] = []
    @Published var monthlyStepData: [StepData] = []
    @Published var halfYearStepData: [StepData] = []
    @Published var yearlyStepData: [StepData] = []
    @Published var allStepData: [StepData] = []

    // 세그먼트
    @Published var selectedSegment: SegmentsModel = .day {
        didSet { loadData(for: selectedSegment) }
    }
    // 총 걸음수 계산 (더미 데이터 기준 합계)
    var totalSteps: Int {
        chartData(for: selectedSegment).map(\.stepCount).reduce(0, +)
    }
    
   // 총 저축된 수명(분) 계산: 예를 들어 1,000걸음당 1분이라 가정
    var totalSavedMinutes: Double {
        Double(totalSteps) / 1000.0
    }
    
    init() {
        loadData(for: selectedSegment)
    }

    func loadData(for segment: SegmentsModel) {
        switch segment {
        case .day:
            hourlyStepData = (0..<24).map {
                StepData(hour: $0, stepCount: Int.random(in: 200...500))
            }
        case .week:
            weeklyStepData = (0..<7).map {
                StepData(hour: $0, stepCount: Int.random(in: 3000...10000))
            }
        case .month:
            monthlyStepData = (1...30).map {
                StepData(hour: $0, stepCount: Int.random(in: 2000...9000))
            }
        case .halfYear:
            halfYearStepData = (1...6).map {
                StepData(hour: $0, stepCount: Int.random(in: 100000...200000))
            }
        case .year:
            yearlyStepData = (1...12).map {
                StepData(hour: $0, stepCount: Int.random(in: 150000...300000))
            }
        case .all:
            allStepData = (1...5).map {
                StepData(hour: $0, stepCount: Int.random(in: 500000...800000))
            }
        }
    }
    
    func chartData(for segment: SegmentsModel) -> [StepData] {
        switch segment {
        case .day:
            return hourlyStepData
        case .week:
            return weeklyStepData
        case .month:
            return monthlyStepData
        case .halfYear:
            return halfYearStepData
        case .year:
            return yearlyStepData
        case .all:
            return allStepData
        }
    }
    
}


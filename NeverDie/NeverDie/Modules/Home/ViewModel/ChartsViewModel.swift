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
    
    // 날짜 데이터 사용
    @Published var currentDate: Date = Date()
    
    // 선택된 기간에 따른 걸음 수 데이터
    @Published var hourlyStepData: [StepData] = []
    
    // 세그먼트
    @Published var selectedSegment: SegmentsModel = .day {
        didSet { loadData(for: selectedSegment) }
    }

    // 총 걸음수 계산 (더미 데이터 기준 합계)
    var totalSteps: Int {
        hourlyStepData.map(\.stepCount).reduce(0, +)
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
            hourlyStepData = (0..<7).map {
                StepData(hour: $0, stepCount: Int.random(in: 3000...10000))
            }
        case .month:
            hourlyStepData = (1...30).map {
                StepData(hour: $0, stepCount: Int.random(in: 2000...9000))
            }
        case .halfYear:
            hourlyStepData = (1...6).map {
                StepData(hour: $0, stepCount: Int.random(in: 100000...200000))
            }
        case .year:
            hourlyStepData = (1...12).map {
                StepData(hour: $0, stepCount: Int.random(in: 150000...300000))
            }
        case .all:
            hourlyStepData = (1...5).map {
                StepData(hour: $0, stepCount: Int.random(in: 500000...800000))
            }
        }
    }
}



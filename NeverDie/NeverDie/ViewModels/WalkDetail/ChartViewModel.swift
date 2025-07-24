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
    
    // 선택된 기간에 따른 걸음 수 데이터를 담는 배열
    @Published var hourlyStepData: [StepData] = []
    
    // 현재 선택된 세그먼트 (기본값은 .day)
    @Published var selectedSegment: SegmentsModel = .day {
        didSet {
            // 세그먼트가 변경되면 해당 데이터 로드
            loadData(for: selectedSegment)
        }
    }

    // 초기화 시 기본 세그먼트(.day)의 데이터 로드
    init() {
        loadData(for: selectedSegment)
    }

    // 세그먼트에 따라 더미 데이터를 생성하는 메서드
    func loadData(for segment: SegmentsModel) {
        switch segment {
        case .day:
            // 시간 단위 (0시 ~ 23시)로 24개의 더미 걸음 수 데이터 생성
            hourlyStepData = (0..<24).map { hour in
                StepData(hour: hour, stepCount: Int.random(in: 200...500))
            }

        case .week:
            // 요일 단위 (0~6, 총 7일간)로 하루 평균 걸음 수 데이터 생성
            hourlyStepData = (0..<7).map { day in
                StepData(hour: day, stepCount: Int.random(in: 3000...10000))
            }

        case .month:
            // 날짜 단위 (1일 ~ 30일)로 하루 걸음 수 데이터 생성
            hourlyStepData = (1...30).map { day in
                StepData(hour: day, stepCount: Int.random(in: 2000...9000))
            }

        case .halfYear:
            // 월 단위 (1월 ~ 6월)로 월별 누적 걸음 수 데이터 생성
            hourlyStepData = (1...6).map { month in
                StepData(hour: month, stepCount: Int.random(in: 100000...200000))
            }

        case .year:
            // 월 단위 (1월 ~ 12월)로 월별 누적 걸음 수 데이터 생성
            hourlyStepData = (1...12).map { month in
                StepData(hour: month, stepCount: Int.random(in: 150000...300000))
            }

        case .all:
            // 연도 단위 (1~5년)로 연간 누적 걸음 수 데이터 생성
            hourlyStepData = (1...5).map { year in
                StepData(hour: year, stepCount: Int.random(in: 500000...800000))
            }
        }
    }
}

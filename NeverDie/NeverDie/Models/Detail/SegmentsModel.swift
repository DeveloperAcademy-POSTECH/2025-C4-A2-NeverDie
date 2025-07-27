//
//  SegmentsModel.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import Foundation

enum SegmentsModel: String, CaseIterable, Identifiable {
    case day = "1일"
    case week = "1주"
    case month = "1개월"
    case halfYear = "6개월"
    case year = "1년"
    case all = "전체"
    
    var id: String { self.rawValue }
    
    // MARK: 걸음수 타이틀
    var stepTitle: String {
        switch self {
        case .day: return "오늘 총 걸음수"
        case .week, .month: return "평균 걸음수"
        case .halfYear, .year, .all: return "일일 평균 걸음수"
        }
    }
    
    // MARK: 누적 수명 타이틀
    var lifespanTitle: String {
        switch self {
        case .day: return "오늘 누적 수명"
        case .week: return "이번주 누적 수명"
        case .month: return "1개월 누적 수명"
        case .halfYear: return "6개월 누적 수명"
        case .year: return "1년 누적 수명"
        case .all: return "전체 누적 수명"
        }
    }
    
    // MARK: 세그먼트별 날짜 범위 텍스트 (e.g. "7월 21일 ~ 7월 27일")
        func dateRangeText(from referenceDate: Date, firstRecordDate: Date? = nil) -> String {
            let calendar = Calendar.current
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "M월 d일"

            let startDate: Date
            let endDate: Date

            switch self {
            case .day:
                // 당일
                return formatter.string(from: referenceDate)

            case .week:
                startDate = calendar.date(byAdding: .day, value: -6, to: referenceDate)!
                endDate = referenceDate

            case .month:
                startDate = calendar.date(byAdding: .weekOfYear, value: -4, to: referenceDate)!
                endDate = referenceDate

            case .halfYear:
                startDate = calendar.date(byAdding: .month, value: -5, to: referenceDate)!
                endDate = referenceDate

            case .year:
                startDate = calendar.date(byAdding: .year, value: -1, to: referenceDate)!
                endDate = referenceDate

            case .all:
                guard let first = firstRecordDate else {
                    return "기록 없음"
                }
                let firstYear = calendar.component(.year, from: first)
                let currentYear = calendar.component(.year, from: referenceDate)
                return "\(firstYear)년 ~ \(currentYear)년"
            }

            return "\(formatter.string(from: startDate)) ~ \(formatter.string(from: endDate))"
        }
    
    
    // MARK: 임시 차트 축 데이터
    func sampleStepData() -> [StepData] {
        switch self {
        case .day:
            return (0..<24).map { StepData(hour: $0, stepCount: Int.random(in: 500...2000)) }
        case .week:
            return (0..<7).map { StepData(hour: $0, stepCount: Int.random(in: 3000...8000)) }
        case .month:
            return (0..<30).map { StepData(hour: $0, stepCount: Int.random(in: 2000...10000)) }
        case .halfYear:
            return (0..<26).map { StepData(hour: $0, stepCount: Int.random(in: 5000...15000)) }
        case .year:
            return (0..<12).map { StepData(hour: $0, stepCount: Int.random(in: 7000...20000)) }
        case .all:
            return (0..<5).map { StepData(hour: $0, stepCount: Int.random(in: 10000...30000)) }
        }
    }
}

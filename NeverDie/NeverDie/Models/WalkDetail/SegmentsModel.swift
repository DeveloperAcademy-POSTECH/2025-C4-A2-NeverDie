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
    
    // MARK: Identifiable 프로토콜 준수를 위한 ID
    var id: String { self.rawValue }
    
    // MARK: 각 세그먼트에 적용 시킬 문구
    var prefixText: String {
        switch self {
        case .day: return "오늘"
        case .week: return "이번 주"
        case .month: return "이번 달"
        case .halfYear: return "최근 6개월간"
        case .year: return "올해"
        case .all: return "전체 기간 동안"
        }
    }
    
    // MARK: 공통 문구와 결합된 전체 문장
    var FeedbackText: String {
        return "\(prefixText) 저축한 수명이에요."
    }
}

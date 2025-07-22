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
}

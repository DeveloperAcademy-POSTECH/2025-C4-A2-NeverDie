//
//  ChartsModel.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/22/25.
//

import Foundation

// 시간대별 걸음 수 데이터 모델
struct StepData: Identifiable {
    let id = UUID()
    let hour: Int           // 예: 0 ~ 23
    let stepCount: Int      // 시간대별 걸음 수
    var savedMinutes: Double {
        // 100걸음당 1분 저축된 수명
        return Double(stepCount) / 100.0
    }
}

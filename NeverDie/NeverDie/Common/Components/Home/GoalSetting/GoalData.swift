//
//  GoalData.swift
//  NeverDie
//
//  Created by 길정수 on 7/28/25.
//

import Foundation
import SwiftUI

/// 단계 정보
struct StageData: Identifiable {
    let id = UUID()
    let stageNum: Int
    let stageContent: String
    let stageGoal: Int
}

/// 지표별 데이터
struct IndicatorData: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let text: String
    let stages: [StageData]
}

/// 전체 데이터
let goalInfoList: [IndicatorData] = [
    IndicatorData(
        icon: .stepCountIcon,
        text: "걸음수",
        stages: [
            StageData(stageNum: 1, stageContent: "하루에 4,000걸음 걷기", stageGoal: 4000),
            StageData(stageNum: 2, stageContent: "하루에 8,000걸음 걷기", stageGoal: 8000),
            StageData(stageNum: 3, stageContent: "하루에 13,000걸음 걷기", stageGoal: 13000)
        ]
    )
    /// 추후 추가 가능
]

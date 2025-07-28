//
//  GoalProgressBar.swift
//  NeverDie
//
//  Created by 길정수 on 7/28/25.
//

import SwiftUI

/// 진행률 막대의 길이를 유동적으로 계산하기 위한 함수
/// 퍼센트와 최대 길이(화면 가로 길이)를 받아서 해당 퍼센트의 길이를 계산
private func progressBarWidth(for percent: Int, maxWidth: CGFloat) -> CGFloat {
    let clampedPercent = max(0, min(percent, 100))
    return maxWidth * CGFloat(clampedPercent) / 100
}

struct GoalProgressBar: View {
    let barHeight: CGFloat
    let percent: Int
    
    var body: some View {
        /// 목표의 진행률을 나타내는 막대: %에 따라 유동적으로 나타남
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(height: barHeight)
                    .foregroundStyle(Color.grayCaption00)
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: progressBarWidth(for: percent, maxWidth: geometry.size.width), height: barHeight)
                    .foregroundStyle(Color.green01)
            }
        }
        .frame(height: barHeight)
    }
}

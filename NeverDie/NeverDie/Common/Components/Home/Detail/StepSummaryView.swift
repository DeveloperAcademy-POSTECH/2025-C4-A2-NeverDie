//
//  StepSummaryView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/25/25.
//

import SwiftUI

/// 걸음수 또는 수명 요약 정보를 보여주는 뷰
struct StepSummaryView: View {
    var title: String
    var color: Color
    var value: Int           // 분 단위 수명 또는 걸음 수
    var unit: String         // 단위 (걸음 / 분)
    var subtitle: String
    var isTimeValue: Bool = false  // 시간 변환 여부 (true일 경우 시간 포맷으로 표시)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 아이콘 + 타이틀
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 10, height: 10)
                Text(title)
                    .font(.captionSemiBold12)
                    .foregroundStyle(.grayCaption02)
            }

            // 수치 출력
            (
                Text(isTimeValue ? formatTime(from: value) : "\(value.formatted())")
                    .font(.largeTitleSemiBold32)
                +
                Text(isTimeValue ? "" : " \(unit)") // 시간이면 단위 생략
                    .font(.calloutSemiBold14)
                    .foregroundStyle(.grayCaption02)
            )

            // 보조 텍스트
            Text(subtitle)
                .font(.captionSemiBold12)
                .foregroundStyle(.grayCaption02)
        }
    }

    /// 분 단위를 → "X일 Y시간 Z분" 형태로 포맷
    private func formatTime(from minutes: Int) -> String {
        let days = minutes / (24 * 60)
        let hours = (minutes % (24 * 60)) / 60
        let mins = minutes % 60

        var components: [String] = []
        if days > 0 { components.append("\(days)일") }
        if hours > 0 { components.append("\(hours)시간") }
        if mins > 0 || components.isEmpty { components.append("\(mins)분") }

        return components.joined(separator: " ")
    }
}

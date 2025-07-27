//
//  StepCountGoalChart.swift
//  NeverDie
//
//  Created by 길정수 on 7/26/25.
//

import Charts
import SwiftUI

struct StepCountGoalChart: View {
    
    // MARK: - Property
    
    /// 가장 최근 날짜를 저장: 최근 날짜만 컬러를 주기 위함
    private let lastDay = dummyChartData.last7days.last?.day
    
    // MARK: - Body
    var body: some View {
        Chart {
            ForEach(dummyChartData.last7days, id: \.day) { data in
                BarMark(
                    x: .value("Hour", data.day, unit: .day),
                    y: .value("걸음수", data.stepCount)
                )
                .foregroundStyle(data.day == lastDay ? Color.green01 : Color.grayCaption01)
            }
        }
        .frame(width: 120, height: 70)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

// MARK: - Preview
#Preview {
    StepCountGoalChart()
}


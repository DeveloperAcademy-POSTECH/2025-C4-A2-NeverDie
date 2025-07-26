//
//  StepCountGoalChart.swift
//  NeverDie
//
//  Created by 길정수 on 7/26/25.
//

import Charts
import SwiftUI

struct StepCountGoalChart: View {
    private let lastDay = dummyChartData.last7days.last?.day
    
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

#Preview {
    StepCountGoalChart()
}


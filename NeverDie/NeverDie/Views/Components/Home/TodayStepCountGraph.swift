//
//  TodayStepCountChart.swift
//  NeverDie
//
//  Created by 길정수 on 7/21/25.
//

import Charts
import SwiftUI


func date(year: Int, month: Int, day: Int = 1, hour: Int = 0) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour)) ?? Date()
}

struct stepCountData {
    static let last12Hours = [
        (hour: date(year: 2025, month: 7, day: 21, hour: 4), stepCount: 3820),
        (hour: date(year: 2025, month: 7, day: 21, hour: 5), stepCount: 1932),
        (hour: date(year: 2025, month: 7, day: 21, hour: 6), stepCount: 1713),
        (hour: date(year: 2025, month: 7, day: 21, hour: 7), stepCount: 950),
        (hour: date(year: 2025, month: 7, day: 21, hour: 8), stepCount: 1053),
        (hour: date(year: 2025, month: 7, day: 21, hour: 9), stepCount: 3490),
        (hour: date(year: 2025, month: 7, day: 21, hour: 10), stepCount: 1734),
        (hour: date(year: 2025, month: 7, day: 21, hour: 11), stepCount: 1823),
        (hour: date(year: 2025, month: 7, day: 21, hour: 12), stepCount: 911),
        (hour: date(year: 2025, month: 7, day: 21, hour: 13), stepCount: 1044),
        (hour: date(year: 2025, month: 7, day: 21, hour: 14), stepCount: 992),
        (hour: date(year: 2025, month: 7, day: 21, hour: 15), stepCount: 1012)
    ]
}

struct TodayStepCountChart: View {
    
    var body: some View {
        Chart {
            ForEach(stepCountData.last12Hours, id: \.hour) { data in
                BarMark(
                    x: .value("Hour", data.hour, unit: .hour),
                    y: .value("걸음수", data.stepCount)
                )
            }
        }
        .frame(height: 144)
        .foregroundStyle(
            LinearGradient(
                gradient: Gradient(colors: [Color.greenChart01Linear01, Color.greenChart01Linear02]),
                startPoint: .top, endPoint: .bottom
            )
        )
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour, count: 3)) {
                AxisTick()
                AxisGridLine()
            }
        }
    }
}

#Preview {
    TodayStepCountChart()
}

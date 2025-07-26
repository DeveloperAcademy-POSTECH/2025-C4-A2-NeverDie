//
//  TodayLifeSavingChart.swift
//  NeverDie
//
//  Created by 길정수 on 7/25/25.
//

import Charts
import SwiftUI


func date(year: Int, month: Int, day: Int = 1, hour: Int = 0) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour)) ?? Date()
}
struct stepCountData {
    static let last12Hours = [
        (hour: date(year: 2025, month: 7, day: 21, hour: 4), life: 38),
        (hour: date(year: 2025, month: 7, day: 21, hour: 5), life: 12),
        (hour: date(year: 2025, month: 7, day: 21, hour: 6), life: 13),
        (hour: date(year: 2025, month: 7, day: 21, hour: 7), life: 44),
        (hour: date(year: 2025, month: 7, day: 21, hour: 8), life: 34),
        (hour: date(year: 2025, month: 7, day: 21, hour: 9), life: 25),
        (hour: date(year: 2025, month: 7, day: 21, hour: 10), life: 33),
        (hour: date(year: 2025, month: 7, day: 21, hour: 11), life: 23),
        (hour: date(year: 2025, month: 7, day: 21, hour: 12), life: 36),
        (hour: date(year: 2025, month: 7, day: 21, hour: 13), life: 12),
        (hour: date(year: 2025, month: 7, day: 21, hour: 14), life: 23)    ]
}

struct TodayLifeSavingChart: View {
    
    var body: some View {
        Chart {
            ForEach(stepCountData.last12Hours, id: \.hour) { data in
                AreaMark(
                    x: .value("Hour", data.hour, unit: .hour),
                    y: .value("수명", data.life)
                )
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.grdientBlue01, Color.clear]),
                        startPoint: .top, endPoint: .bottom
                    )
                )
            }
            ForEach(stepCountData.last12Hours, id: \.hour) { data in
                LineMark(
                    x: .value("Hour", data.hour, unit: .hour),
                    y: .value("수명", data.life)
                )
                .foregroundStyle(Color.blue01)
                .symbol {
                    Circle()
                        .strokeBorder(Color.blue01, lineWidth: 3)
                        .background(
                            Circle()
                                .foregroundColor(Color.white01)
                        )
                        .frame(width: 12, height: 12)
                }
            }
            
        }
        .foregroundStyle(Color.blue01)
        .frame(height: 170)
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour, count: 3)) { value in
                AxisTick()
                AxisGridLine()
                AxisValueLabel() {
                    if let date = value.as(Date.self) {
                        let hour = Calendar.current.component(.hour, from: date)
                        Text("\(hour)시")
                    }
                }
            }
        }

    }
}

#Preview {
    TodayLifeSavingChart()
}

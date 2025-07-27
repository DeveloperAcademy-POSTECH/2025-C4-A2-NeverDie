//
//  TodayLifeSavingChart.swift
//  NeverDie
//
//  Created by 길정수 on 7/25/25.
//

import Charts
import SwiftUI

/// 년, 월, 일, 시를 입력하여 Date 객체로 만들어주는 함수
func date(year: Int, month: Int, day: Int = 1, hour: Int = 0) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour)) ?? Date()
}

// MARK: - DummyData
struct dummyChartData {
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
        (hour: date(year: 2025, month: 7, day: 21, hour: 14), life: 23)
    ]
    
    static let last7days = [
        (day: date(year: 2025, month: 7, day: 20), stepCount: 24945),
        (day: date(year: 2025, month: 7, day: 21), stepCount: 22438),
        (day: date(year: 2025, month: 7, day: 22), stepCount: 18812),
        (day: date(year: 2025, month: 7, day: 23), stepCount: 20033),
        (day: date(year: 2025, month: 7, day: 24), stepCount: 8344),
        (day: date(year: 2025, month: 7, day: 25), stepCount: 7434),
        (day: date(year: 2025, month: 7, day: 26), stepCount: 10528)
    ]
}

struct TodayLifeSavingChart: View {
    
    // MARK: - Body
    var body: some View {
        Chart {
            ForEach(dummyChartData.last12Hours, id: \.hour) { data in
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
            ForEach(dummyChartData.last12Hours, id: \.hour) { data in
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

// MARK: - Preview
#Preview {
    TodayLifeSavingChart()
}

//
//  TodayLifeSavingChart.swift
//  NeverDie
//
//  Created by 길정수 on 7/25/25.
//

import Charts
import SwiftUI

// MARK: - DummyData
struct DummyLifeSpanData {
    
    /// 최근 12시간의 LifeSpan 더미 데이터 생성
    static var last12Hours: [LifeSpan] {
        let calendar = Calendar.current
        let now = Date()
        var data: [LifeSpan] = []
        
        for hourOffset in (-11...0) {
            let date = calendar.date(byAdding: .hour, value: hourOffset, to: now)!
            let hour = calendar.component(.hour, from: date)
            // 임의의 수명 변화량: 10 ~ 30분 범위 내 랜덤 값
            let lifeSpanChange = Double.random(in: 10...30)
            data.append(LifeSpan(date: date, hour: hour, lifeSpanChange: lifeSpanChange))
        }
        return data
    }
}

struct TodayLifeSavingChart: View {
    // MARK: - Property
    let dummtData = DummyLifeSpanData.last12Hours
    
    // MARK: - Body
    var body: some View {
        
        // 더미 데이터에서 최대값 구하기
        let maxValue = dummtData.map { $0.lifeSpanChange }.max() ?? 0
        let upperBound = Int(ceil(maxValue / 20)) * 20
        let ticks = Array(stride(from: 0, through: upperBound, by: 20))

        Chart {
            ForEach(dummtData, id: \.startTime) { lifeSpan in
                AreaMark(
                    x: .value("Hour", lifeSpan.startTime, unit: .hour),
                    y: .value("수명", lifeSpan.lifeSpanChange)
                )
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.grdientBlue01, Color.clear]),
                        startPoint: .top, endPoint: .bottom
                    )
                )
                LineMark(
                    x: .value("Hour", lifeSpan.startTime, unit: .hour),
                    y: .value("수명", lifeSpan.lifeSpanChange)
                )
                .foregroundStyle(Color.blue01)
                .lineStyle(StrokeStyle(lineWidth: 2))
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
        .chartYScale(domain: 0 ... upperBound)
        .chartYAxis {
            AxisMarks(values: ticks) { value in
                AxisTick()
                AxisGridLine()
                AxisValueLabel()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    TodayLifeSavingChart()
}

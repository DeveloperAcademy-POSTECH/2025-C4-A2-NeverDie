//
//  LineChartsView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/25/25.
//

import SwiftUI
import Charts

struct LineChartsView: View {
    let data: [StepData]
    
    var body: some View {
        Chart {
            ForEach(data) { dataPoint in
                LineMark(
                    x: .value("시간", dataPoint.hour),
                    y: .value("저축된 수명(분)", dataPoint.savedMinutes)
                )
                .foregroundStyle(.blue01)
                .lineStyle(StrokeStyle(lineWidth: 2, lineJoin: .round))
                .symbol(Circle())
                .symbolSize(40)
            }
        }
        .frame(width: 320, height: 200)
    }
}


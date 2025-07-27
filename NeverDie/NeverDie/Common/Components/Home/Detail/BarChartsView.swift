//
//  BarChartsView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/25/25.
//

import SwiftUI
import Charts

struct BarChartsView: View {
    let data: [StepData]
    
    var body: some View {
        Chart {
            ForEach(data) { dataPoint in
                BarMark(
                    x: .value("시간", dataPoint.hour),
                    y: .value("걸음 수", dataPoint.stepCount)
                )
                .foregroundStyle(.greenChart02)
            }
        }
        .frame(width: 354, height: 200)
    }
}

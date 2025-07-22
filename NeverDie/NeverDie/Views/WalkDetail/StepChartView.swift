//
//  StepChartView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/22/25.
//

import SwiftUI
import Charts

struct StepChartView: View {
    @StateObject private var viewModel = StepChartViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ChartsTopView()

            // 차트
            Chart {
                ForEach(viewModel.hourlyStepData) { data in
                    BarMark(
                        x: .value("Hour", data.hour),
                        y: .value("Steps", data.stepCount)
                    )
                    .foregroundStyle(Color.green)
                    
                    LineMark(
                        x: .value("Hour", data.hour),
                        y: .value("Saved", data.savedMinutes)
                    )
                    .foregroundStyle(Color.blue)
                    .symbol(Circle())
                    .interpolationMethod(.monotone)
                }
            }
            .frame(height: 260)
            .padding(.horizontal)
            
            Spacer()
        }
        .safeAreaPadding(.horizontal, 24)
    }
    
}

#Preview {
    StepChartView()
}

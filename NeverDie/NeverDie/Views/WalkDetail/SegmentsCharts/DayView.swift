//
//  DayView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import SwiftUI
import Charts

struct DayView: View {
    var body: some View {
        StepChartView(
            data: SegmentsModel.day.sampleStepData(),
            title: "1일 걸음수 & 저축 수명"
        )
    }
}


#Preview {
    DayView()
}

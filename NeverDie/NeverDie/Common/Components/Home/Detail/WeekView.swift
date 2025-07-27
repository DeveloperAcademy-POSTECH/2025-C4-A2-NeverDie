//
//  WeekView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import SwiftUI
import Charts


struct WeekView: View {
    var body: some View {
        BarChartsView(
            data: SegmentsModel.week.sampleStepData()
        )
    }
}

#Preview {
    WeekView()
}

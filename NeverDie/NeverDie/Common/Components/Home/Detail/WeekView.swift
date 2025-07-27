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
//            title: "1주일 걸음수 & 저축 수명"
        )
    }
}

#Preview {
    WeekView()
}

//
//  HalfYearView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import SwiftUI
import Charts

struct HalfYearView: View {
    var body: some View {
        BarChartsView(
            data: SegmentsModel.halfYear.sampleStepData()
        )
    }
}

#Preview {
    HalfYearView()
}

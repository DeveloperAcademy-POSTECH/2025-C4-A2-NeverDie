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
        StepChartsView(
            data: SegmentsModel.halfYear.sampleStepData(),
            title: "6개월 걸음수 & 저축 수명"
        )
    }
}

#Preview {
    HalfYearView()
}

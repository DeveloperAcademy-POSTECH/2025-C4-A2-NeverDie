//
//  YearView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import SwiftUI
import Charts

struct YearView: View {
    var body: some View {
        BarChartsView(
            data: SegmentsModel.year.sampleStepData()
//            title: "1년 걸음수 & 저축 수명"
        )
    }
}
#Preview {
    YearView()
}

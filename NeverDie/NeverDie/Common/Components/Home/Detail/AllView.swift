//
//  AllView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import SwiftUI
import Charts

struct AllView: View {
    var body: some View {
        BarChartsView(
            data: SegmentsModel.all.sampleStepData()
//            title: "전체 걸음수 & 저축 수명"
        )
    }
}

#Preview {
    AllView()
}

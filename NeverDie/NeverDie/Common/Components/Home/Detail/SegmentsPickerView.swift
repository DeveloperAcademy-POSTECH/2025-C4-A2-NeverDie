//
//  SegmentsPickerView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/24/25.
//

import SwiftUI

struct SegmentsPickerView: View {
    @Binding var selectedSegment: SegmentsModel   // 상위 뷰와 바인딩
    
    var body: some View {
        Picker("기간", selection: $selectedSegment) {
            ForEach(SegmentsModel.allCases) { segment in
                Text(segment.rawValue)
                    .tag(segment)
            }
        }
        .pickerStyle(.segmented)

    }
}

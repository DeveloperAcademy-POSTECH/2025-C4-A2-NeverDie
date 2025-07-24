//
//  SegmentsPicker.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/23/25.
//

import SwiftUI

struct SegmentsPickerView: View {
    @State private var selectedSegment: SegmentsModel = .day // 기본 세팅 값
    
    var body: some View {
        VStack(spacing: 20) {
            // 세그먼트 피커
            Picker("기간 선택", selection: $selectedSegment) {
                ForEach(SegmentsModel.allCases) { segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
            .pickerStyle(.palette)
            .font(.segmentLabelRegular13)
            .padding()

            // 선택된 세그먼트에 따라 다른 View 보여주기
            Group {
                switch selectedSegment {
                case .day:
                    DayView()
                case .week:
                    WeekView()
                case .month:
                    MonthView()
                case .halfYear:
                    HalfYearView()
                case .year:
                    YearView()
                case .all:
                    AllView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    SegmentsPickerView()
}

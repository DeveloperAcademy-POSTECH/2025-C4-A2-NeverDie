//
//  DayView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/21/25.
//

import SwiftUI
import Charts

struct DayView: View {
    let segment: SegmentsModel = .day
    
    var body: some View {
        Text(segment.FeedbackText)
    }
}

#Preview {
    DayView()
}

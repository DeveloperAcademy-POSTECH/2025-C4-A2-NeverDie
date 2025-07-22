//
//  Feedback.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/22/25.
//

import SwiftUI

struct FeedbackView: View {
    let segment: SegmentsModel = .day
    
    var body: some View {
        HStack {
            Text(segment.FeedbackText)
                .font(.body)
                .foregroundColor(.white)
            Spacer()
            Text("timeText")
                .font(.headline.bold())
                .foregroundColor(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.green)
        )
        .padding(.horizontal)
    }
}

#Preview {
    FeedbackView()
}

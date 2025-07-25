//
//  ChartsTop.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/22/25.
//

import SwiftUI
import Charts

struct ChartsTopView: View {
    @Binding var selectedSegment: SegmentsModel
    @StateObject private var viewModel = StepChartsViewModel()
    
    var body: some View {
        topView
    }
    
    private var topView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 70) {
                
                // 걸음수
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Circle()
                            .fill(Color.greenChart02)
                            .frame(width: 10, height: 10)
                        Text(selectedSegment.stepTitle)
                            .font(.captionSemiBold12)
                            .foregroundStyle(.grayCaption02)
                    }
                    Text("\(viewModel.totalSteps.formatted())")
                        .font(.largeTitleSemiBold32)
                    + Text(" 걸음")
                        .font(.calloutSemiBold14)
                        .foregroundStyle(.grayCaption02)
                }
                
                // 수명
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                        Text(selectedSegment.lifespanTitle)
                            .font(.captionSemiBold12)
                            .foregroundStyle(.grayCaption02)
                    }
                    Text("\(Int(viewModel.totalSavedMinutes))")
                        .font(.largeTitleSemiBold32)
                    + Text(" 분")
                        .font(.calloutSemiBold14)
                        .foregroundStyle(.grayCaption02)
                }
                
                Spacer()
            }
            // 오늘 날짜
            Text(formattedDate(viewModel.currentDate))
                .font(.captionSemiBold12)
                .foregroundColor(.grayCaption03)
        }
        .padding()
    }
}


// 날짜 포맷 함수
private func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "M월 d일"
    return formatter.string(from: date)
}


//
//  HomeView.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import SwiftUI
import Charts
struct timeData: Identifiable {
    let id = UUID()
    let day: Int?
    let hour: Int?
    let minute: Int
}

struct TodaySummaryModel: Identifiable {
    let id = UUID()
    let lifeSaving: timeData
}

struct HomeView: View {
    
    let todaySummaryData = TodaySummaryModel(
        lifeSaving: timeData(day: nil, hour: 1, minute: 30)
    )
    
    var body: some View {
        ScrollView {
            topContents
        }
        .background(Color.grayBg)
        .safeAreaPadding(.horizontal, 16)
    }
    
    private var topContents: some View {
        Button(action: {
            print("상세보기 클릭")
        }) {
            VStack(spacing: 10) {
                TodayLifeSaving(lifeSaving: todaySummaryData.lifeSaving)
                TodayLifeSavingChart()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white01)
            )
        }
    }

}

#Preview {
    HomeView()
}

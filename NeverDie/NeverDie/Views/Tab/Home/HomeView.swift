//
//  HomeView.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import SwiftUI
struct RecentHistoryModel: Identifiable {
    let id = UUID()
    let stepCount: Int
    let startTime: Int
    let lifeSpanChange: Int
}

struct TodaySummaryModel: Identifiable {
    let id = UUID()
    let date: String
    let lifeSaving: String
}

struct HomeView: View {
    // 더미 데이터
    let recentHistories: [RecentHistoryModel] = [
        RecentHistoryModel(stepCount: 10, startTime: 22, lifeSpanChange: -10),
        RecentHistoryModel(stepCount: 9432, startTime: 21, lifeSpanChange: +12),
        RecentHistoryModel(stepCount: 5689, startTime: 20, lifeSpanChange: +8),
        RecentHistoryModel(stepCount: 246, startTime: 19, lifeSpanChange: -10),
        RecentHistoryModel(stepCount: 15124, startTime: 18, lifeSpanChange: +30)
    ]
    
    let todaySummaryData: TodaySummaryModel = TodaySummaryModel(date: "2025.07.16", lifeSaving: "1시간 27분")
    
    var body: some View {
        ScrollView {
            VStack (spacing: 30) {
                todaySummary
                recentHistory
            }
        }
        .safeAreaPadding(.horizontal, 24)
    }
    
    private var todaySummary: some View {
        VStack(spacing: 10) {
            TodayLifeSaving(date: todaySummaryData.date, lifeSaving: todaySummaryData.lifeSaving)
        }
    }
    
    private var recentHistory: some View {
        VStack (alignment: .leading, spacing: 15) {
            Text("최근 내역")
                .font(.headlineBold24)
                .foregroundStyle(Color.black01)
                .padding(.horizontal, 5)
            
            LazyVStack {
                ForEach(recentHistories) { item in
                    RecentHistoryItem(
                        stepCount: item.stepCount,
                        startTime: item.startTime,
                        lifeSpanChange: item.lifeSpanChange
                    )
                }
            }
            .padding(.leading, 7)
            .padding(.trailing, 21)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}

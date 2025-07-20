import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/giljeongsu/Desktop/🍎/C4/2025-C4-A2-NeverDie/NeverDie/NeverDie/Views/Tab/Home/HomeView.swift", line: 1)
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

struct HomeView: View {
    // 더미 데이터
    let recentHistories: [RecentHistoryModel] = [
        RecentHistoryModel(stepCount: 12457, startTime: 22, lifeSpanChange: -30),
        RecentHistoryModel(stepCount: 9432, startTime: 20, lifeSpanChange: +12),
        RecentHistoryModel(stepCount: 5689, startTime: 21, lifeSpanChange: +8),
        RecentHistoryModel(stepCount: 246, startTime: 19, lifeSpanChange: -2),
        RecentHistoryModel(stepCount: 15124, startTime: 23, lifeSpanChange: +30)
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                RecentHistory
            }
        }
        .safeAreaPadding(.horizontal, __designTimeInteger("#19884_0", fallback: 24))
    }
    
    private var RecentHistory: some View {
        VStack (alignment: .leading, spacing: __designTimeInteger("#19884_1", fallback: 15)) {
            Text(__designTimeString("#19884_2", fallback: "최근 내역"))
                .font(.headlineBold24)
                .foregroundStyle(Color.black01)
            
            LazyVStack {
                ForEach(recentHistories) { item in
                    RecentHistoryItem(
                        stepCount: item.stepCount,
                        startTime: item.startTime,
                        lifeSpanChange: item.lifeSpanChange
                    )
                }
            }
            .padding(.leading, __designTimeInteger("#19884_3", fallback: 7))
            .padding(.trailing, __designTimeInteger("#19884_4", fallback: 21))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}

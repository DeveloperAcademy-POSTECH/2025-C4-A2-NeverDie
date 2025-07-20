import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/giljeongsu/Desktop/🍎/C4/2025-C4-A2-NeverDie/NeverDie/NeverDie/Views/Tab/TopTabBar.swift", line: 1)
//
//  TopTabBar.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "홈"
    case report = "리포트"
    case mypage = "마이페이지"
}

struct TopTabBar: View {
    @State var selectedTab: Tab = .home
    
    var body: some View {
        VStack (spacing: __designTimeInteger("#19612_0", fallback: 10)) {
            HStack(spacing: __designTimeInteger("#19612_1", fallback: 4)) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    tabButton(for: tab)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .report:
                    ReportView()
                case .mypage:
                    MyPageView()
                }
            }
        }
        .padding(.horizontal, __designTimeInteger("#19612_2", fallback: 24))
    }
    
    private func tabButton(for tab: Tab) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            Text(tab.rawValue)
                .font(.titleBold28)
                .foregroundColor(selectedTab == tab ? .green03 : .grayCaption01)
                .figmaLineHeight(fontSize: __designTimeInteger("#19612_3", fallback: 28))
                .padding(.horizontal, __designTimeInteger("#19612_4", fallback: 5))
        }
    }
}

#Preview {
    TopTabBar()
}

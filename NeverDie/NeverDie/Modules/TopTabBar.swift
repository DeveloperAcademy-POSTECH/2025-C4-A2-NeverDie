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
        VStack (spacing: 10) {
            HStack(spacing: 4) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    tabButton(for: tab)
                }
            }
            .safeAreaPadding(.horizontal, 24)
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
    }
    
    private func tabButton(for tab: Tab) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            Text(tab.rawValue)
                .font(.titleBold28)
                .foregroundColor(selectedTab == tab ? .green03 : .grayCaption01)
                .figmaLineHeight(fontSize: 28)
                .padding(.horizontal, 5)
        }
    }
}

#Preview {
    TopTabBar()
}

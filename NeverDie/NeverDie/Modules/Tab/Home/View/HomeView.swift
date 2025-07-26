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
    @State private var showDialog = false
    
    let todaySummaryData = TodaySummaryModel(
        lifeSaving: timeData(day: nil, hour: 1, minute: 30)
    )
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                topContents
                bottomContents
            }
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
    
    private var bottomContents: some View {
        VStack(alignment: .leading, spacing: 8) {
            bottomContentsTitle
            
            GoalStatus(sectionIcon: ImageResource.stepCountIcon, sectionTitle: "걸음수", goalStage: 3, currentStatus: 10521, goal: 13000, percent: 80)
            
        }
    }
    
    private var bottomContentsTitle: some View {
        HStack {
            Text("목표 현황")
                .font(.b24)
                .foregroundStyle(Color.black01)
                .figmaLineHeight(fontSize: 24)
            
            Spacer()
            
            Button(action: {
                print("메뉴 버튼 클릭")
                showDialog = true
            }) {
                Image(systemName: "ellipsis")
                    .font(.sfR16)
                    .foregroundStyle(Color.grayCaption02)
                    .figmaLineHeight(fontSize: 16)
            }
            .confirmationDialog("",
                        isPresented: $showDialog
                    ) {
                        Button("목표 설정") { print("목표 설정 클릭") }
                        Button("목표 삭제", role: .destructive) { print("목표 삭제 클릭") }
                    }
            
        }
        .padding(.horizontal, 19)
    }
}

#Preview {
    HomeView()
}

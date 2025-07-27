//
//  HomeView.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import SwiftUI

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
    @State private var showAddGoalModalView = false
    @State private var showDetailView = false
    
    let todaySummaryData = TodaySummaryModel(
        lifeSaving: timeData(day: nil, hour: 1, minute: 30)
    )
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    topContents
                    bottomContents
                }
            }
            .background(Color.grayBg)
            .safeAreaPadding(.horizontal, 16)
            .navigationDestination(isPresented: $showDetailView){
                StepDetailView()
            }
        }
    }
    
    private var topContents: some View {
        Button(action: {
            print("상세보기 클릭")
            showDetailView = true
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
                showAddGoalModalView = true
            }) {
                Image(systemName: "plus")
                    .font(.sfR16)
                    .foregroundStyle(Color.grayCaption02)
                    .figmaLineHeight(fontSize: 16)
            }
            .sheet(isPresented:$showAddGoalModalView) {
                AddGoalModalView()
                    .presentationDetents([.fraction(1)])
                    .interactiveDismissDisabled(false)
            }
            
        }
        .padding(.horizontal, 19)
    }
}

#Preview {
    HomeView()
}

struct HomeView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

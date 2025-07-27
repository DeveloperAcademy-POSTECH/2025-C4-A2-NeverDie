//
//  HomeView.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import SwiftUI

// MARK: - DummyData Model

struct timeData: Identifiable {
    let id = UUID()
    let day: Int?
    let hour: Int?
    let minute: Int
}

struct HomeView: View {
    
    // MARK: - Property
    
    /// 모달을 보여줄지 말지
    @State private var showAddGoalModalView = false
    
    /// 상세 뷰로 이동할지 말지
    @State private var showDetailView = false
    
    // MARK: - DummyData
    let todaySummaryData = timeData(day: nil, hour: 1, minute: 30)
    
    // MARK: - Body
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
    
    // MARK: - TopContents
    /// 상단 컨텐츠: 오늘의 저축 수명 섹션 (시간 + 지난 12시간 그래프)
    private var topContents: some View {
        Button(action: {
            showDetailView = true
        }) {
            VStack(spacing: 10) {
                TodayLifeSaving(lifeSaving: todaySummaryData)
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
    
    // MARK: - BottomContents
    // 하단 컨텐츠: 목표 현황 섹션(헤더 + 반복 컴포넌트)
    private var bottomContents: some View {
        VStack(alignment: .leading, spacing: 8) {
            bottomContentsHeader
            
            GoalStatus(icon: ImageResource.stepCountIcon, title: "걸음수", goalStage: 3, currentStatus: 10521, goal: 13000, percent: 80)
            
        }
    }
    
    /// '목표 현황' 섹션의 헤더: 타이틀 + 추가 버튼
    /// + 버튼을 클릭시 AddGoalModalView가 나타남
    private var bottomContentsHeader: some View {
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


// MARK: - Preview
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

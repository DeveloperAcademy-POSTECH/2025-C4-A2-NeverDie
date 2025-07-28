//
//  HomeView.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import SwiftUI
import SwiftData

// MARK: - DummyData Model

struct HomeView: View {
    
    // MARK: - Property
    @Environment(\.modelContext) private var modelContext
    
    /// 뷰모델
    @State private var viewModel = HomeViewModel(
        lifeSpanService: LifeSpanService(),
        healthKitService: HealthKitService()
    )
    
    /// 모달을 보여줄지 말지
    @State private var showAddGoalModalView = false
    
    /// 상세 뷰로 이동할지 말지
    @State private var showDetailView = false
    
    /// 자동 동기화 관련 (앱 실행시마다)
    @State private var syncService: SyncService?
    @State private var autoSyncHealthKitService: HealthKitService?
    @State private var autoSyncLifeSpanService: LifeSpanService?
    @State private var hasAutoSynced = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    topContents
                    bottomContents
                }
            }
            .refreshable {
                // 새로고침시 동기화 실행 → HomeViewModel 데이터 갱신
                await performRefreshSync()
            }
            .background(Color.grayBg)
            .safeAreaPadding(.horizontal, 16)
            .navigationDestination(isPresented: $showDetailView){
                StepDetailView()
            }
        }
        .task {
            // HomeViewModel에 ModelContext 설정하고 데이터 로드
            viewModel.configure(with: modelContext)
            
            // 앱 실행시마다 자동 동기화
            await performAutoSyncIfNeeded()
        }
    }
    
    // MARK: - TopContents
    /// 상단 컨텐츠: 오늘의 저축 수명 섹션 (시간 + 지난 12시간 그래프)
    private var topContents: some View {
        Button(action: {
            showDetailView = true
        }) {
            VStack(spacing: 10) {
                TodayLifeSaving(lifeSaving: viewModel.todayLifeSavingData)
                TodayLifeSavingChart(lifeSpanData: viewModel.todayLifeSpanData)
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
            
            GoalStatus(
                icon: ImageResource.stepCountIcon,
                title: "걸음수",
                goalStage: 3,
                walkingSessions: viewModel.weeklyWalkingSessions
            )
            
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

// MARK: - Auto Sync (Every Launch)
extension HomeView {
    
    /// 앱 실행시마다 자동 동기화 수행
    private func performAutoSyncIfNeeded() async {
        // 이미 이 세션에서 동기화했다면 스킵
        guard !hasAutoSynced else { return }
        
        await performSync(isAutoSync: true)
        hasAutoSynced = true
    }
    
    /// 새로고침시 동기화 수행
    private func performRefreshSync() async {
        await performSync(isAutoSync: false)
    }
    
    /// 실제 동기화 수행 (공통 로직)
    private func performSync(isAutoSync: Bool) async {
        let syncType = isAutoSync ? "자동" : "새로고침"
        print("🔄 \(syncType) 동기화 시작")
        
        // 서비스 인스턴스 초기화 (한 번만)
        if autoSyncHealthKitService == nil {
            autoSyncHealthKitService = HealthKitService()
            autoSyncLifeSpanService = LifeSpanService()
            autoSyncLifeSpanService?.configure(with: modelContext)
            syncService = SyncService(
                healthKitService: autoSyncHealthKitService!,
                lifeSpanService: autoSyncLifeSpanService!
            )
        }
        
        // 동기화 실행
        await syncService?.syncAllData(modelContext: modelContext)
        print("✅ \(syncType) 동기화 완료")
        
        // 새로고침이면 HomeViewModel 데이터도 갱신
        if !isAutoSync {
            await viewModel.refreshData()
        }
    }
}

// MARK: - Preview

struct HomeView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView()
                .modelContainer(for: [WalkingSession.self, LifeSpan.self], inMemory: true)
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

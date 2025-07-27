//
//  SyncTestView.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import SwiftUI
import SwiftData
import UIKit

struct SyncTestView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var syncService: SyncService
    @StateObject private var healthKitService = HealthKitService()
    @StateObject private var lifeSpanService = LifeSpanService()
    
    // SwiftData 조회
    @Query private var allWalkingSessions: [WalkingSession]
    @Query private var allLifeSpans: [LifeSpan]
    
    init() {
        let healthKit = HealthKitService()
        let lifeSpan = LifeSpanService()
        let sync = SyncService(healthKitService: healthKit, lifeSpanService: lifeSpan)
        
        _healthKitService = StateObject(wrappedValue: healthKit)
        _lifeSpanService = StateObject(wrappedValue: lifeSpan)
        _syncService = StateObject(wrappedValue: sync)
    }
    
    // 최근 5개 걷기 세션 (최신순)
    private var recentWalkingSessions: [WalkingSession] {
        allWalkingSessions
            .sorted { $0.startTime > $1.startTime }
            .prefix(5)
            .map { $0 }
    }
    
    // 오늘 총 걸음 수
    private var todayTotalSteps: Int {
        let today = Calendar.current.startOfDay(for: Date())
        return allWalkingSessions
            .filter { Calendar.current.isDate($0.date, inSameDayAs: today) }
            .reduce(0) { $0 + $1.stepCount }
    }
    
    // 총 수명 변화량
    private var totalLifeSpanChange: Double {
        allLifeSpans.reduce(0) { $0 + $1.lifeSpanChange }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                
                // 제목
                Text("동기화 테스트")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // 동기화 상태 카드
                VStack(spacing: 20) {
                    
                    // 마지막 동기화 시간
                    VStack(spacing: 8) {
                        Text("마지막 동기화")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(syncService.formattedLastSyncDate)
                            .font(.body)
                    }
                    
                    // 진행률 표시
                    if syncService.isSync {
                        VStack(spacing: 12) {
                            Text(syncService.syncMessage)
                                .font(.body)
                                .foregroundColor(.secondary)
                            
                            ProgressView(value: syncService.syncProgress)
                                .frame(height: 8)
                            
                            Text("\(syncService.syncProgressPercent)%")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // 동기화 버튼
                    Button(action: {
                        Task {
                            // LifeSpanService에 modelContext 설정
                            lifeSpanService.configure(with: modelContext)
                            
                            // 동기화 실행
                            await syncService.syncAllData(modelContext: modelContext)
                        }
                    }) {
                        HStack {
                            if syncService.isSync {
                                ProgressView()
                                    .scaleEffect(0.8)
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: "arrow.clockwise")
                            }
                            
                            Text(syncService.isSync ? "동기화 중..." : "전체 동기화 시작")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(syncService.isSync ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(syncService.isSync)
                    
                    // 디버깅: 수동 수명 변환 버튼
                    if !allWalkingSessions.isEmpty && !syncService.isSync {
                        Button(action: {
                            Task {
                                                                 print("🔍 수동 수명 변환 시작 (디버깅)")
                                 print("🔍 현재 WalkingSession 개수: \(allWalkingSessions.count)")
                                 print("🔍 현재 LifeSpan 개수: \(allLifeSpans.count)")
                                 
                                 // 첫 번째 WalkingSession 날짜로 테스트
                                 if let firstSession = allWalkingSessions.first {
                                     let testDate = firstSession.date
                                     print("🔍 테스트 날짜: \(testDate)")
                                     print("🔍 테스트 시간: \(firstSession.hour)시")
                                     print("🔍 테스트 걸음수: \(firstSession.stepCount)")
                                     
                                     await lifeSpanService.convertDailyWalkingSessions(for: testDate)
                                     print("🔍 수동 변환 완료")
                                     
                                     // 변환 후 다시 확인
                                     print("🔍 변환 후 LifeSpan 개수: \(allLifeSpans.count)")
                                 }
                            }
                        }) {
                            HStack {
                                Image(systemName: "wrench.and.screwdriver")
                                Text("수명 변환 테스트")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                    
                }
                .padding(20)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                // 저장된 데이터 요약
                VStack(spacing: 20) {
                    Text("저장된 데이터")
                        .font(.headline)
                    
                    VStack(spacing: 15) {
                        // 첫 번째 줄: 데이터 개수
                        HStack(spacing: 15) {
                            VStack(spacing: 8) {
                                Text("걷기 세션")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(allWalkingSessions.count)개")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(12)
                            
                            VStack(spacing: 8) {
                                Text("수명 데이터")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(allLifeSpans.count)개")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                        }
                        
                        // 두 번째 줄: 통계 정보
                        HStack(spacing: 15) {
                            VStack(spacing: 8) {
                                Text("오늘 걸음")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(todayTotalSteps)")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(12)
                            
                            VStack(spacing: 8) {
                                Text("총 수명 변화")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(String(format: "%.1f분", totalLifeSpanChange))
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(totalLifeSpanChange >= 0 ? .green : .red)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                    
                    // 최근 데이터 미리보기
                    if !allWalkingSessions.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("최근 걷기 데이터")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            ForEach(recentWalkingSessions, id: \.startTime) { session in
                                HStack {
                                    Text(session.formattedTimeSlot)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                    
                                    Text("\(session.stepCount)걸음")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                    
                                    Text(session.formattedDistance)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal, 8)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(radius: 2)
                
                // HealthKit 권한 상태
                VStack(spacing: 15) {
                    Text("HealthKit 권한: \(healthKitService.isAuthorized ? "✅" : "❌")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 15) {
                        if !healthKitService.isAuthorized {
                            Button("권한 요청") {
                                Task {
                                    await healthKitService.requestHealthKitPermissions()
                                    // 권한 요청 후 상태 다시 확인
                                    await healthKitService.checkAuthorizationStatus()
                                }
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                        
                        Button("🔄 상태 새로고침") {
                            Task {
                                print("🔄 수동 권한 상태 새로고침")
                                await healthKitService.checkAuthorizationStatus()
                            }
                        }
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    // 권한 허용 방법 안내
                    if !healthKitService.isAuthorized {
                        VStack(spacing: 8) {
                            Text("권한 허용 방법:")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("1. 설정 앱 → 개인정보 보호 및 보안")
                                Text("2. 건강 → NeverDie")
                                Text("3. '걸음수' 켜기")
                                Text("")
                                Text("⚠️ 한번 거부하면 앱에서 재요청 불가")
                                    .foregroundColor(.orange)
                                    .fontWeight(.medium)
                            }
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            
                            Button("설정으로 이동") {
                                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(settingsUrl)
                                }
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.top, 4)
                        }
                        .padding()
                        .background(Color.yellow.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
                .padding(.bottom)
                
                }
                .padding(20)
            }
            .navigationTitle("동기화 테스트")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            // 뷰 로드시 LifeSpanService 설정
            lifeSpanService.configure(with: modelContext)
            
            // HealthKit 권한 상태만 확인 (요청하지 않음)
            await healthKitService.checkAuthorizationStatus()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // 앱이 포그라운드로 돌아올 때 권한 상태 재확인
            Task {
                print("📱 앱 포그라운드 복귀 - 권한 상태 재확인")
                await healthKitService.checkAuthorizationStatus()
            }
        }
    }
}

#Preview {
    SyncTestView()
} 
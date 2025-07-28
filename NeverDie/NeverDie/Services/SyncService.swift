//
//  SyncService.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import Foundation
import SwiftData

@MainActor
class SyncService: ObservableObject {
    
    // MARK: - 진행 상태 추적
    @Published var isSync = false
    @Published var syncProgress: Double = 0.0  // 0.0 ~ 1.0
    @Published var syncMessage: String = ""
    @Published var lastSyncDate: Date?
    
    // MARK: - 서비스 의존성
    private let healthKitService: HealthKitService
    private let lifeSpanService: LifeSpanService
    
    // MARK: - 초기화
    init(healthKitService: HealthKitService, lifeSpanService: LifeSpanService) {
        self.healthKitService = healthKitService
        self.lifeSpanService = lifeSpanService
    }
    
    // MARK: - 전체 동기화
    
    /// 전체 HealthKit 데이터를 동기화 (HealthKit → WalkingSession → LifeSpan)
    func syncAllData(modelContext: ModelContext) async {
        guard !isSync else { return }
        
        isSync = true
        syncProgress = 0.0
        syncMessage = "동기화 준비 중..."
        
        // LifeSpanService에 modelContext 설정
        lifeSpanService.configure(with: modelContext)
        
        defer {
            isSync = false
            syncProgress = 1.0
        }
        
        do {
            // 1단계: HealthKit → WalkingSession (전체 기간)
            syncMessage = "HealthKit 데이터 가져오는 중..."
            syncProgress = 0.1
            
            await healthKitService.fetchAndConvertAllWalkingSessions(modelContext: modelContext)
            
            // 2단계: WalkingSession → LifeSpan (전체 변환)
            syncMessage = "수명 데이터 변환 중..."
            syncProgress = 0.5
            
            await convertAllWalkingSessionsToLifeSpan(modelContext: modelContext)
            
            // 3단계: 완료 처리
            syncMessage = "동기화 완료!"
            lastSyncDate = Date()
            
        } catch {
            syncMessage = "동기화 실패: \(error.localizedDescription)"
        }
    }
    
    // MARK: - Helper 메서드
    
    /// 모든 WalkingSession을 LifeSpan으로 변환
    private func convertAllWalkingSessionsToLifeSpan(modelContext: ModelContext) async {
        do {
            // 모든 WalkingSession 조회
            let allSessions = try modelContext.fetch(FetchDescriptor<WalkingSession>())
            
            // 날짜별로 그룹화하여 변환
            let groupedSessions = Dictionary(grouping: allSessions) { session in
                Calendar.current.startOfDay(for: session.date)
            }
            
            let sortedDates = groupedSessions.keys.sorted()
            
            for (index, date) in sortedDates.enumerated() {
                syncMessage = "수명 변환 중..."
                
                await lifeSpanService.convertDailyWalkingSessions(for: date)
                
                // 진행률 업데이트 (0.5부터 0.9까지)
                let progress = 0.5 + (Double(index + 1) / Double(sortedDates.count)) * 0.4
                syncProgress = progress
                
                // UI 업데이트를 위한 짧은 대기
                try await Task.sleep(nanoseconds: 10_000_000) // 0.01초
            }
            
        } catch {
            // 에러 처리
        }
    }
    
    /// 마지막 동기화 시간 포맷팅
    var formattedLastSyncDate: String {
        guard let lastSyncDate = lastSyncDate else {
            return "동기화한 적 없음"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: lastSyncDate)
    }
    
    /// 동기화 진행률 퍼센트
    var syncProgressPercent: Int {
        return Int(syncProgress * 100)
    }
} 
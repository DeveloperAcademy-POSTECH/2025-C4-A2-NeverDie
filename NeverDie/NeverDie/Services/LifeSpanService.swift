//
//  LifeSpanService.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import Foundation
import SwiftData

// MARK: - 수명 관리 서비스
@MainActor
class LifeSpanService: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isProcessing = false
    
    // MARK: - Private Properties
    private var modelContext: ModelContext?
    
    // MARK: - Initialization
    init() {
        // 초기화 시 기본값 설정
    }
    
    func configure(with modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - WalkingSession → LifeSpan 변환
    
    /// WalkingSession 데이터를 LifeSpan으로 변환하여 저장
    func convertWalkingSessionToLifeSpan(walkingSession: WalkingSession) async {
        guard let modelContext = modelContext else { return }
        
        isProcessing = true
        defer { isProcessing = false }
        
        // 1. 수명 변화량 계산
        let lifeSpanChange = LifeSpanCalculator.calculateLifeSpanChange(from: walkingSession.stepCount)
        
        // 2. 기존 수명 데이터가 있는지 확인
        if let existingLifeSpan = try? findExistingLifeSpan(
            date: walkingSession.date,
            hour: walkingSession.hour,
            in: modelContext
        ) {
            // 기존 데이터 업데이트
            existingLifeSpan.lifeSpanChange = lifeSpanChange
        } else {
            // 새로운 LifeSpan 생성
            let lifeSpan = LifeSpan(
                date: walkingSession.date,
                hour: walkingSession.hour,
                lifeSpanChange: lifeSpanChange
            )
            
            modelContext.insert(lifeSpan)
        }
        
        // 3. 변경사항 저장
        do {
            try modelContext.save()
        } catch {
            print("❌ LifeSpan 저장 에러: \(error)")
        }
    }
    
    /// 특정 날짜의 모든 WalkingSession을 LifeSpan으로 일괄 변환
    func convertDailyWalkingSessions(for date: Date) async {
        guard let modelContext = modelContext else { return }
        
        isProcessing = true
        defer { isProcessing = false }
        
        do {
            // 해당 날짜의 모든 WalkingSession 조회
            let walkingSessions = try fetchWalkingSessions(for: date, in: modelContext)
            
            // 각 세션을 LifeSpan으로 변환
            for session in walkingSessions {
                await convertWalkingSessionToLifeSpan(walkingSession: session)
            }
            
        } catch {
            print("❌ LifeSpan 일괄 변환 에러: \(error)")
        }
    }
    
    // MARK: - 데이터 조회 메서드
    
    /// 특정 날짜의 WalkingSession들 조회
    private func fetchWalkingSessions(for date: Date, in modelContext: ModelContext) throws -> [WalkingSession] {
        let allSessions = try modelContext.fetch(FetchDescriptor<WalkingSession>())
        return allSessions.filter { session in
            Calendar.current.isDate(session.date, inSameDayAs: date)
        }.sorted { $0.hour < $1.hour }
    }
    
    /// 특정 날짜/시간의 기존 LifeSpan 찾기
    private func findExistingLifeSpan(date: Date, hour: Int, in modelContext: ModelContext) throws -> LifeSpan? {
        let allLifeSpans = try modelContext.fetch(FetchDescriptor<LifeSpan>())
        return allLifeSpans.first { lifeSpan in
            Calendar.current.isDate(lifeSpan.date, inSameDayAs: date) && lifeSpan.hour == hour
        }
    }
    

    
    // MARK: - 편의 메서드
    
    /// 특정 날짜의 저장된 LifeSpan 조회 및 출력 (디버깅용)
    func printStoredLifeSpans(for date: Date) {
        guard let modelContext = modelContext else { return }
        
        do {
            let allLifeSpans = try modelContext.fetch(FetchDescriptor<LifeSpan>())
            let filteredLifeSpans = allLifeSpans.filter { lifeSpan in
                Calendar.current.isDate(lifeSpan.date, inSameDayAs: date)
            }.sorted { $0.hour < $1.hour }
            
            print("📊 \(date.formatted(date: .abbreviated, time: .omitted)) 수명 데이터:")
            if filteredLifeSpans.isEmpty {
                print("   데이터 없음")
            } else {
                for lifeSpan in filteredLifeSpans {
                    print("   \(lifeSpan.formattedTimeSlot): \(lifeSpan.formattedLifeSpanChange) (\(lifeSpan.changeEmoji))")
                }
                
                let totalChange = filteredLifeSpans.reduce(0) { $0 + $1.lifeSpanChange }
                print("   총 변화량: \(totalChange >= 0 ? "+" : "")\(String(format: "%.1f분", totalChange))")
            }
        } catch {
            
        }
    }
    
    /// 전체 저장된 LifeSpan 개수 확인
    func getTotalStoredLifeSpansCount() -> Int {
        guard let modelContext = modelContext else { return 0 }
        
        do {
            let lifeSpans = try modelContext.fetch(FetchDescriptor<LifeSpan>())
            return lifeSpans.count
        } catch {
            return 0
        }
    }
    
    /// 모든 LifeSpan 데이터 삭제 (테스트용)
    func clearAllLifeSpans() {
        guard let modelContext = modelContext else { return }
        
        do {
            let lifeSpans = try modelContext.fetch(FetchDescriptor<LifeSpan>())
            for lifeSpan in lifeSpans {
                modelContext.delete(lifeSpan)
            }
            try modelContext.save()
        } catch {
            
        }
    }
}

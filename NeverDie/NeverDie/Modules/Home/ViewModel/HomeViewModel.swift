//
//  HomeViewModel.swift
//  NeverDie
//
//  Created by 길정수 on 7/28/25.
//

import Foundation
import SwiftData
import SwiftUI

struct timeData: Identifiable {
    let id = UUID()
    let day: Int?
    let hour: Int?
    let minute: Int?
}

@Observable
final class HomeViewModel {
    var todayLifeSpanData: [LifeSpan] = []
    var weeklyWalkingSessions: [WalkingSession] = []
    
    // 오늘 총 수명 증가량 계산
    var todayLifeSavingData: timeData {
        let totalMinutes = todayLifeSpanData.reduce(0) { $0 + $1.lifeSpanChange }
        
        // 시와 분 계산
        let hours = Int(totalMinutes) / 60
        let minutes = Int(totalMinutes) % 60
        
        return timeData(
            day: nil,
            hour: hours == 0 ? nil : hours,
            minute: minutes == 0 ? nil: minutes
        )
    }
    
    private let lifeSpanService: LifeSpanService
    private let healthKitService: HealthKitService
    private var modelContext: ModelContext?
    
    init(lifeSpanService: LifeSpanService, healthKitService: HealthKitService) {
        self.lifeSpanService = lifeSpanService
        self.healthKitService = healthKitService
    }
    
    func configure(with modelContext: ModelContext) {
        self.modelContext = modelContext
        Task {
            await loadInitialData()
        }
    }
    
    // 실제 SwiftData에서 데이터 로드
    func loadInitialData() async {
        guard let modelContext = modelContext else { return }
        
        await MainActor.run {
            do {
                // 오늘 LifeSpan 데이터 조회
                todayLifeSpanData = try fetchTodayLifeSpanData(from: modelContext)
                
                // 최근 7일 WalkingSession 데이터 조회
                weeklyWalkingSessions = try fetchWeeklyWalkingSessions(from: modelContext)
                
                print("📊 HomeViewModel 데이터 로드 완료")
                print("   - 오늘 LifeSpan: \(todayLifeSpanData.count)개")
                print("   - 주간 WalkingSession: \(weeklyWalkingSessions.count)개")
                
            } catch {
                print("❌ HomeViewModel 데이터 로드 실패: \(error)")
                // 에러 발생시 빈 배열로 초기화
                todayLifeSpanData = []
                weeklyWalkingSessions = []
            }
        }
    }
    
    func refreshData() async {
        await loadInitialData()
    }
    
    // MARK: - 실제 데이터 조회 메서드
    
    private func fetchTodayLifeSpanData(from modelContext: ModelContext) throws -> [LifeSpan] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let descriptor = FetchDescriptor<LifeSpan>()
        let allLifeSpans = try modelContext.fetch(descriptor)
        
        return allLifeSpans.filter { lifeSpan in
            calendar.isDate(lifeSpan.date, inSameDayAs: today)
        }.sorted { $0.hour < $1.hour }
    }
    
    private func fetchWeeklyWalkingSessions(from modelContext: ModelContext) throws -> [WalkingSession] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let weekAgo = calendar.date(byAdding: .day, value: -6, to: today)!
        
        let descriptor = FetchDescriptor<WalkingSession>()
        let allSessions = try modelContext.fetch(descriptor)
        
        return allSessions.filter { session in
            session.date >= weekAgo && session.date <= today
        }.sorted { $0.date < $1.date }
    }
}


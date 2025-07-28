//
//  HomeViewModel.swift
//  NeverDie
//
//  Created by 길정수 on 7/28/25.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
final class HomeViewModel {
    var todayLifeSpanData: [LifeSpan] = []
    var weeklyWalkingSessions: [WalkingSession] = []

    private let lifeSpanService: LifeSpanService
    private let healthKitService: HealthKitService
    
    init(lifeSpanService: LifeSpanService, healthKitService: HealthKitService) {
        self.lifeSpanService = lifeSpanService
        self.healthKitService = healthKitService
        
        Task {
            await loadInitialData()
        }
    }
    
    // 초기 데이터 또는 더미 데이터를 세팅하는 함수
    func loadInitialData() async {
        // 예: 더미 데이터 세팅
        todayLifeSpanData = createDummyLifeSpanData()
        weeklyWalkingSessions = createDummyWalkingSessions()
        
        // 추후 실제 서비스 연동 시에는
        // 여기서 lifeSpanService 및 healthKitService 호출해서 데이터 받아서 할당
    }
    
    func refreshData() async {
        await loadInitialData()
    }

    // MARK: - 더미 데이터 생성 메서드

    private func createDummyLifeSpanData() -> [LifeSpan] {
        let calendar = Calendar.current
        let now = Date()
        var data: [LifeSpan] = []

        for hourOffset in (-11...0) {
            let date = calendar.date(byAdding: .hour, value: hourOffset, to: now)!
            let hour = calendar.component(.hour, from: date)
            let lifeSpanChange = Double.random(in: 10...30)
            data.append(LifeSpan(date: date, hour: hour, lifeSpanChange: lifeSpanChange))
        }
        return data
    }

    private func createDummyWalkingSessions() -> [WalkingSession] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let stepCounts = [24945, 22438, 18812, 20033, 8344, 7434, 10528]

        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: -6 + offset, to: today)!
            let stepCount = stepCounts[offset]
            let distance = Double(stepCount) * 0.7
            let calories = Double(stepCount) * 0.04
            return WalkingSession(
                date: date,
                hour: 12,
                distance: distance,
                stepCount: stepCount,
                calories: calories
            )
        }
    }
}


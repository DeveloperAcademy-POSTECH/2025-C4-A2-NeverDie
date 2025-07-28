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
    
    // (임시) TodayLifeSaving에 전달할 timeData 타입의 속성 추가
    var todayLifeSavingData: timeData {
        // 0~720분 사이 랜덤 값 생성
        let totalMinutes = Int.random(in: 0...120)
        
        // 시와 분 계산
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        return timeData(
            day: nil,
            hour: hours == 0 ? nil : hours,
            minute: minutes == 0 ? nil: minutes
        )
    }

    
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
            let lifeSpanChange = Double.random(in: 10...30) // 10~30분 수명 범위 랜덤
            data.append(LifeSpan(date: date, hour: hour, lifeSpanChange: lifeSpanChange))
        }
        return data
    }
    
    private func createDummyWalkingSessions() -> [WalkingSession] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var data: [WalkingSession] = []
        
        for dayOffset in (-6...0) {
            let date = calendar.date(byAdding: .day, value: dayOffset, to: today)!
            let randomStepCount = Int.random(in: 5000...15000) // 5,000~15,000 걸음 범위 랜덤
            let distance = Double(randomStepCount) * 0.7
            let calories = Double(randomStepCount) * 0.04
            let session = WalkingSession(
                date: date,
                hour: 12,
                distance: distance,
                stepCount: randomStepCount,
                calories: calories
            )
            data.append(session)
        }
        return data
    }
}


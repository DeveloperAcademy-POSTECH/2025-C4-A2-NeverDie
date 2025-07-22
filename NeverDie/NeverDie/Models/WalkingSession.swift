//
//  WalkingSession.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import Foundation
import SwiftData

// MARK: - 걷기 세션 모델
@Model
final class WalkingSession {
    var startTime: Date
    var endTime: Date
    var distance: Double    // 거리 (미터)
    var stepCount: Int      // 걸음 수
    var calories: Double    // 소모 칼로리 (kcal)
    var routeName: String?  // 경로 이름 (선택사항)
    
    // MARK: - 계산된 속성
    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime)
    }
    
    var durationInMinutes: Double {
        return duration / 60.0
    }
    
    var averageSpeed: Double {
        guard duration > 0 else { return 0 }
        return (distance / 1000) / (duration / 3600) // km/h
    }
    
    var pace: Double {
        guard distance > 0 else { return 0 }
        return (duration / 60) / (distance / 1000) // 분/km
    }
    
    // MARK: - 초기화
    init(
        startTime: Date,
        endTime: Date,
        distance: Double,
        stepCount: Int,
        calories: Double,
        routeName: String? = nil
    ) {
        self.startTime = startTime
        self.endTime = endTime
        self.distance = distance
        self.stepCount = stepCount
        self.calories = calories
        self.routeName = routeName
    }
}

// MARK: - 편의 메서드
extension WalkingSession {
    static func createSampleSession() -> WalkingSession {
        let start = Date()
        let end = start.addingTimeInterval(1800) // 30분 후
        
        return WalkingSession(
            startTime: start,
            endTime: end,
            distance: 2500.0,    // 2.5km
            stepCount: 3200,     // 3200걸음
            calories: 180.5,     // 180.5kcal
            routeName: "집 근처 산책로"
        )
    }
    
    var formattedDistance: String {
        if distance >= 1000 {
            return String(format: "%.2f km", distance / 1000)
        } else {
            return String(format: "%.0f m", distance)
        }
    }
    
    var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        
        if hours > 0 {
            return String(format: "%d시간 %d분", hours, minutes)
        } else {
            return String(format: "%d분", minutes)
        }
    }
    
    var formattedCalories: String {
        return String(format: "%.1f kcal", calories)
    }
    
    var formattedAverageSpeed: String {
        return String(format: "%.1f km/h", averageSpeed)
    }
    
    var formattedPace: String {
        let minutes = Int(pace)
        let seconds = Int((pace - Double(minutes)) * 60)
        return String(format: "%d'%02d\"/km", minutes, seconds)
    }
} 
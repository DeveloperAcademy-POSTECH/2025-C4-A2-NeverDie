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
    var date: Date          // 날짜 (시간은 00:00:00으로 정규화)
    var hour: Int           // 시간 (0-23)
    var distance: Double    // 거리 (미터)
    var stepCount: Int      // 걸음 수
    var calories: Double    // 소모 칼로리 (kcal)
    
    // MARK: - 계산된 속성
    var startTime: Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: hour, minute: 0, second: 0, of: date) ?? date
    }
    
    var endTime: Date {
        return startTime.addingTimeInterval(3600) // 1시간 후
    }
    
    var duration: TimeInterval {
        return 3600 // 1시간 고정
    }
    
    var durationInMinutes: Double {
        return 60.0 // 60분 고정
    }
    
    var averageSpeed: Double {
        guard distance > 0 else { return 0 }
        return (distance / 1000) // km/h (1시간이므로 거리/1000이 곧 속도)
    }
    
    var pace: Double {
        guard distance > 0 else { return 0 }
        return 60.0 / (distance / 1000) // 분/km (60분 / km)
    }
    
    // MARK: - 초기화
    init(
        date: Date,
        hour: Int,
        distance: Double,
        stepCount: Int,
        calories: Double
    ) {
        // 날짜를 00:00:00으로 정규화
        let calendar = Calendar.current
        self.date = calendar.startOfDay(for: date)
        self.hour = max(0, min(23, hour)) // 0-23 범위로 제한
        self.distance = distance
        self.stepCount = stepCount
        self.calories = calories
    }
}

// MARK: - 편의 메서드
extension WalkingSession {
    static func createSampleSession() -> WalkingSession {
        let now = Date()
        let currentHour = Calendar.current.component(.hour, from: now)
        
        return WalkingSession(
            date: now,
            hour: currentHour,
            distance: 2500.0,    // 2.5km
            stepCount: 3200,     // 3200걸음
            calories: 180.5      // 180.5kcal
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
        return "1시간"
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
    
    var formattedTimeSlot: String {
        return String(format: "%d시 - %d시", hour, (hour + 1) % 24)
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
} 

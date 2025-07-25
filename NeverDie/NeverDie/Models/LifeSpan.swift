//
//  LifeSpan.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import Foundation
import SwiftData

// MARK: - 수명 단위 열거형
enum LifeSpanUnit {
    case minutes
    case hours
    case days
    case months
    case years
    
    var displayName: String {
        switch self {
        case .minutes:
            return "분"
        case .hours:
            return "시간"
        case .days:
            return "일"
        case .months:
            return "개월"
        case .years:
            return "년"
        }
    }
}

// MARK: - 수명 모델
@Model
final class LifeSpan {
    var date: Date          // 날짜 (00:00:00으로 정규화)
    var hour: Int           // 시간 (0-23)
    var lifeSpanChange: Double  // 수명 변화량 (분 단위, 양수=증가, 음수=감소)
    
    // MARK: - 계산된 속성
    var startTime: Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: hour, minute: 0, second: 0, of: date) ?? date
    }
    
    var endTime: Date {
        return startTime.addingTimeInterval(3600) // 1시간 후
    }
    
    var isLifeSpanIncreased: Bool {
        return lifeSpanChange > 0
    }
    
    var lifeSpanChangeInHours: Double {
        return lifeSpanChange / 60.0
    }
    
    var lifeSpanChangeInDays: Double {
        return lifeSpanChange / (60.0 * 24.0)
    }
    
    // MARK: - 초기화
    init(
        date: Date,
        hour: Int,
        lifeSpanChange: Double
    ) {
        // 날짜를 00:00:00으로 정규화
        let calendar = Calendar.current
        self.date = calendar.startOfDay(for: date)
        self.hour = max(0, min(23, hour)) // 0-23 범위로 제한
        self.lifeSpanChange = lifeSpanChange
    }
}

// MARK: - 편의 메서드
extension LifeSpan {
    static func createSampleLifeSpan() -> LifeSpan {
        let now = Date()
        let currentHour = Calendar.current.component(.hour, from: now)
        
        return LifeSpan(
            date: now,
            hour: currentHour,
            lifeSpanChange: 15.5     // 15.5분 수명 증가
        )
    }
    
    // 시간대 표시
    var formattedTimeSlot: String {
        return String(format: "%d시 - %d시", hour, (hour + 1) % 24)
    }
    
    // 날짜 문자열
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    // 수명 변화량 포맷팅
    var formattedLifeSpanChange: String {
        let sign = lifeSpanChange >= 0 ? "+" : ""
        
        if abs(lifeSpanChange) >= 60 {
            let hours = lifeSpanChange / 60.0
            return String(format: "%s%.1f시간", sign, hours)
        } else {
            return String(format: "%s%.1f분", sign, lifeSpanChange)
        }
    }
    

    
    // 상태 이모지
    var changeEmoji: String {
        if lifeSpanChange > 0 {
            return "📈" // 수명 증가
        } else if lifeSpanChange < 0 {
            return "📉" // 수명 감소
        } else {
            return "➖" // 변화 없음
        }
    }
}

// MARK: - 수명 계산 유틸리티
extension LifeSpan {
    /// 년을 분으로 변환
    static func yearsToMinutes(_ years: Double) -> Double {
        return years * 365.25 * 24 * 60
    }
    
    /// 분을 년으로 변환
    static func minutesToYears(_ minutes: Double) -> Double {
        return minutes / (365.25 * 24 * 60)
    }
} 
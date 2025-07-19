//
//  HealthKitTypes.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import Foundation
import HealthKit

// MARK: - HealthKit 데이터 타입 열거형

enum HealthDataType: String, CaseIterable {
    case stepCount = "step_count"
    case activeEnergyBurned = "active_energy_burned"
    case heartRate = "heart_rate"
    case sleepHours = "sleep_hours"
    case distanceWalkingRunning = "distance_walking_running"
    
    var displayName: String {
        switch self {
        case .stepCount:
            return "걸음수"
        case .activeEnergyBurned:
            return "활성 칼로리"
        case .heartRate:
            return "심박수"
        case .sleepHours:
            return "수면시간"
        case .distanceWalkingRunning:
            return "걷기/달리기 거리"
        }
    }
    
    var unit: String {
        switch self {
        case .stepCount:
            return "걸음"
        case .activeEnergyBurned:
            return "kcal"
        case .heartRate:
            return "bpm"
        case .sleepHours:
            return "시간"
        case .distanceWalkingRunning:
            return "km"
        }
    }
    
    var icon: String {
        switch self {
        case .stepCount:
            return "figure.walk"
        case .activeEnergyBurned:
            return "flame.fill"
        case .heartRate:
            return "heart.fill"
        case .sleepHours:
            return "bed.double.fill"
        case .distanceWalkingRunning:
            return "location.fill"
        }
    }
}

// MARK: - HealthKit 데이터 구조체

struct HealthDataPoint {
    let type: HealthDataType
    let value: Double
    let date: Date
    let unit: String
    
    var formattedValue: String {
        switch type {
        case .stepCount:
            return String(format: "%.0f", value)
        case .activeEnergyBurned:
            return String(format: "%.1f", value)
        case .heartRate:
            return String(format: "%.0f", value)
        case .sleepHours:
            return String(format: "%.1f", value)
        case .distanceWalkingRunning:
            return String(format: "%.2f", value / 1000) // 미터를 킬로미터로 변환
        }
    }
}

struct DailyHealthSummary {
    let date: Date
    let stepCount: Double
    let activeEnergyBurned: Double
    let heartRate: Double?
    let sleepHours: Double
    let distanceWalkingRunning: Double
    
    var completionPercentage: Double {
        // 목표 대비 달성률 계산 (예시 목표값 사용)
        let stepGoal: Double = 10000
        let energyGoal: Double = 500
        let sleepGoal: Double = 8
        
        let stepProgress = min(stepCount / stepGoal, 1.0)
        let energyProgress = min(activeEnergyBurned / energyGoal, 1.0)
        let sleepProgress = min(sleepHours / sleepGoal, 1.0)
        
        return (stepProgress + energyProgress + sleepProgress) / 3.0
    }
}

struct WeeklyHealthSummary {
    let weekStartDate: Date
    let dailySummaries: [DailyHealthSummary]
    
    var averageStepCount: Double {
        let total = dailySummaries.reduce(0) { $0 + $1.stepCount }
        return total / Double(dailySummaries.count)
    }
    
    var averageActiveEnergy: Double {
        let total = dailySummaries.reduce(0) { $0 + $1.activeEnergyBurned }
        return total / Double(dailySummaries.count)
    }
    
    var averageSleepHours: Double {
        let total = dailySummaries.reduce(0) { $0 + $1.sleepHours }
        return total / Double(dailySummaries.count)
    }
    
    var totalDistance: Double {
        return dailySummaries.reduce(0) { $0 + $1.distanceWalkingRunning }
    }
}

// MARK: - HealthKit 권한 상태

enum HealthKitAuthorizationStatus {
    case notDetermined
    case denied
    case authorized
    case restricted
    
    var displayText: String {
        switch self {
        case .notDetermined:
            return "권한 미설정"
        case .denied:
            return "권한 거부됨"
        case .authorized:
            return "권한 허용됨"
        case .restricted:
            return "권한 제한됨"
        }
    }
}

// MARK: - HealthKit 오류 타입

enum HealthKitError: Error, LocalizedError {
    case notAvailable
    case notAuthorized
    case dataNotFound
    case networkError
    case unknownError(String)
    
    var errorDescription: String? {
        switch self {
        case .notAvailable:
            return "HealthKit이 이 기기에서 사용할 수 없습니다."
        case .notAuthorized:
            return "HealthKit 사용 권한이 없습니다."
        case .dataNotFound:
            return "요청한 건강 데이터를 찾을 수 없습니다."
        case .networkError:
            return "네트워크 연결에 문제가 있습니다."
        case .unknownError(let message):
            return "알 수 없는 오류: \(message)"
        }
    }
}

// MARK: - HealthKit 목표 설정

struct HealthGoals {
    var stepCount: Double = 10000
    var activeEnergyBurned: Double = 500
    var sleepHours: Double = 8
    var distanceWalkingRunning: Double = 5000 // 미터
    
    func goalProgress(for type: HealthDataType, currentValue: Double) -> Double {
        let goal: Double
        switch type {
        case .stepCount:
            goal = stepCount
        case .activeEnergyBurned:
            goal = activeEnergyBurned
        case .sleepHours:
            goal = sleepHours
        case .distanceWalkingRunning:
            goal = distanceWalkingRunning
        case .heartRate:
            return 1.0 // 심박수는 목표가 없으므로 100% 반환
        }
        
        return min(currentValue / goal, 1.0)
    }
} 
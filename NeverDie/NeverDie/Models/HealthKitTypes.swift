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
    
    var displayName: String {
        switch self {
        case .stepCount:
            return "걸음수"
        }
    }
    
    var unit: String {
        switch self {
        case .stepCount:
            return "걸음"
        }
    }
    
    var icon: String {
        switch self {
        case .stepCount:
            return "figure.walk"
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
        }
    }
}

struct DailyHealthSummary {
    let date: Date
    let stepCount: Double
    
    var goalProgress: Double {
        let stepGoal: Double = 10000
        return min(stepCount / stepGoal, 1.0)
    }
}

struct WeeklyHealthSummary {
    let weekStartDate: Date
    let dailySummaries: [DailyHealthSummary]
    
    var averageStepCount: Double {
        let total = dailySummaries.reduce(0) { $0 + $1.stepCount }
        return total / Double(dailySummaries.count)
    }
    
    var totalStepCount: Double {
        return dailySummaries.reduce(0) { $0 + $1.stepCount }
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
    
    func goalProgress(for type: HealthDataType, currentValue: Double) -> Double {
        switch type {
        case .stepCount:
            return min(currentValue / stepCount, 1.0)
        }
    }
} 

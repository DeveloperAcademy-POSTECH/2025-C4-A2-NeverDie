//
//  UserProfile.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import Foundation
import SwiftData

// MARK: - 사용자 성별 열거형
enum Gender: String, Codable, CaseIterable {
    case male = "male"
    case female = "female"
    case other = "other"
    
    var displayName: String {
        switch self {
        case .male:
            return "남성"
        case .female:
            return "여성"
        case .other:
            return "기타"
        }
    }
}

// MARK: - 사용자 프로필 모델
@Model
final class UserProfile {
    var name: String
    var age: Int
    var gender: Gender
    var height: Double  // cm
    var weight: Double  // kg
    
    // MARK: - 초기화
    init(name: String, age: Int, gender: Gender, height: Double, weight: Double) {
        self.name = name
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
    }
}

// MARK: - 편의 메서드
extension UserProfile {
    static func createSampleProfile() -> UserProfile {
        return UserProfile(
            name: "홍길동",
            age: 30,
            gender: .male,
            height: 175.0,
            weight: 70.0
        )
    }
} 

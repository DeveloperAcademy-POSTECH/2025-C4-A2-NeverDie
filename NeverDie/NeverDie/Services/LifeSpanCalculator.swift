//
//  LifeSpanCalculator.swift
//  NeverDie
//
//  Created by theo on 7/17/25.
//

import Foundation

// MARK: - 수명 계산기
class LifeSpanCalculator {
    
    // MARK: - 기본 계산 상수
    private struct Constants {
        static let baseLifeSpanPerThousandSteps: Double = 7.0    // 1000걸음당 기본 7분 수명 증가
    }
    
    // MARK: - 기본 수명 계산
    /// 걸음 수를 기본 수명 변화량으로 변환
    static func calculateLifeSpanChange(from stepCount: Int) -> Double {
        let thousandSteps = Double(stepCount) / 1000.0
        return thousandSteps * Constants.baseLifeSpanPerThousandSteps
    }
} 

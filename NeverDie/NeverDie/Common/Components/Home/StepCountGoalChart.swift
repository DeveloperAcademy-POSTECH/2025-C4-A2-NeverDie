//
//  StepCountGoalChart.swift
//  NeverDie
//
//  Created by 길정수 on 7/26/25.
//

import Charts
import SwiftUI

// MARK: - DummyData
struct DummyWalkingSessions {
    
    /// 최근 7일간의 WalkingSession 더미 데이터 생성 (일별 대표 데이터, 시간은 12시로 고정)
    static let last7days: [WalkingSession] = {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let stepCounts = [24945, 22438, 18812, 20033, 8344, 7434, 10528]
        
        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: -6 + offset, to: today)!
            let stepCount = stepCounts[offset]
            let distance = Double(stepCount) * 0.7 // 평균보폭 0.7m 적용
            let calories = Double(stepCount) * 0.04 // 걸음당 칼로리 0.04kcal 적용
            
            return WalkingSession(
                date: date,
                hour: 12,
                distance: distance,
                stepCount: stepCount,
                calories: calories
            )
        }
    }()
}

struct StepCountGoalChart: View {
    
    // MARK: - Property
    private let walkingSessions = DummyWalkingSessions.last7days
    
    /// 가장 최근 날짜를 저장: 최근 날짜만 컬러를 주기 위함
    private var lastDay: Date? { walkingSessions.last?.date }
        
    // MARK: - Body
    var body: some View {
        Chart {
            ForEach(walkingSessions, id: \.date) { session in
                BarMark(
                    x: .value("Hour", session.date, unit: .day),
                    y: .value("걸음수", session.stepCount)
                )
                .foregroundStyle(session.date == lastDay ? Color.green01 : Color.grayCaption01)
            }
        }
        .frame(width: 120, height: 70)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

// MARK: - Preview
#Preview {
    StepCountGoalChart()
}


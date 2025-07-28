//
//  StepCountGoalChart.swift
//  NeverDie
//
//  Created by 길정수 on 7/26/25.
//

import Charts
import SwiftUI

struct StepCountGoalChart: View {

    // MARK: - Property
    
    /// 걸음수 데이터
    let walkingSessions: [WalkingSession]
    
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

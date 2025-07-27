//
//  StepChartView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/22/25.
//

import SwiftUI
import Charts

struct StepChartsView: View {
    
    let data: [StepData]        // 외부에서 받은 데이터
    let title: String           // 외부에서 받은 제목
    
    // 뷰모델을 상태 객체로 선언해서 뷰에서 관찰
    @StateObject private var viewModel = StepChartsViewModel()
    
    var body: some View {      
            // 차트 영역
            Chart {
                
                // 데이터 배열을 반복하며 각 데이터 포인트를 그리기
                ForEach(viewModel.hourlyStepData) { data in
                    // BarMark: x축은 시간/일/월, y축은 걸음 수
                    BarMark(
                        x: .value("시간", data.hour),
                        y: .value("걸음 수", data.stepCount)
                    )
                    .foregroundStyle(.greenChart02)
                    
                    // LineMark: x축은 시간/일/월, y축은 저축된 수명(분)
                    LineMark(
                        x: .value("시간", data.hour),
                        y: .value("저축된 수명(분)", data.savedMinutes)
                    )
                    .foregroundStyle(.blue01) // 파란색 꺾은선
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5])) // 점선 스타일
                    .symbol(Circle())         // 각 점을 원으로 표시
                    .symbolSize(30)           // 점 크기 설정
                }
            }
            .frame(height: 300) // 차트 높이 지정
            .padding()
        
    }
}

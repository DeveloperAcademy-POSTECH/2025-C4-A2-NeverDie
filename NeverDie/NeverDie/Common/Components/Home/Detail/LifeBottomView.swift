//
//  LifeBottomView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/26/25.
//

import SwiftUI
import Charts

struct LifeBottomView: View {
    // 상위 뷰에서 선택된 세그먼트 값을 바인딩으로 받음
    @Binding var selectedSegment: SegmentsModel
    
    // 뷰모델 인스턴스를 상태 객체로 관리
    @StateObject private var viewModel = StepChartsViewModel()
    
    var body: some View {
        
        bottomView
        // selectedSegment가 변경될 때 뷰모델의 selectedSegment에 값 전달
            .onChange(of: selectedSegment) { newValue in
                viewModel.selectedSegment = newValue
            }
        
//        LineChartsView(data: viewModel.hourlyStepData)
//            .onAppear {
//                viewModel.selectedSegment = selectedSegment
//            }
//            .onChange(of: selectedSegment) { newValue in
//                viewModel.selectedSegment = newValue
//            }
    }
    
    private var bottomView: some View {
        // 수명(저축된 시간) 정보 표시 영역
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                // 파란색 점 표시
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                
                // 선택된 세그먼트에 따른 수명 제목 표시 (예: "절약된 시간")
                Text(selectedSegment.lifespanTitle)
                    .font(.captionSemiBold12)
                    .foregroundStyle(.grayCaption02)
            }
            // 수명 숫자와 단위를 한 줄에 배치
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                // 수명(분) 숫자, 큰 폰트
                Text("\(Int(viewModel.totalSavedMinutes))")
                    .font(.largeTitleSemiBold32)
                // 단위 "분", 작은 폰트에 회색 스타일
                Text(" 분")
                    .font(.calloutSemiBold14)
                    .foregroundStyle(.grayCaption02)
            }
        }
    }
}

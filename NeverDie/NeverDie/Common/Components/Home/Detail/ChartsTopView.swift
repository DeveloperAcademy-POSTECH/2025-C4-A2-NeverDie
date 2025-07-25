//
//  ChartsTop.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/22/25.
//

import SwiftUI
import Charts

struct ChartsTopView: View {
    // 상위 뷰에서 선택된 세그먼트 값을 바인딩으로 받음
    @Binding var selectedSegment: SegmentsModel
    
    // 뷰모델 인스턴스를 상태 객체로 관리
    @StateObject private var viewModel = StepChartsViewModel()
    
    var body: some View {
        
        StepChartsView(data: viewModel.hourlyStepData, title: selectedSegment.rawValue)
            .onAppear {
                viewModel.selectedSegment = selectedSegment
            }
            .onChange(of: selectedSegment) { newValue in
                viewModel.selectedSegment = newValue
            }
        
        topView
        // selectedSegment가 변경될 때 뷰모델의 selectedSegment에 값 전달
            .onChange(of: selectedSegment) { newValue in
                viewModel.selectedSegment = newValue
            }
        bottomView
            .onChange(of: selectedSegment) { newValue in
                viewModel.selectedSegment = newValue
            }
        
    }
    
    // 실제 UI 구성 뷰
    private var topView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 70) {
                
                // 걸음수 정보 표시 영역
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        // 초록색 점 표시
                        Circle()
                            .fill(Color.greenChart02)
                            .frame(width: 10, height: 10)
                        
                        // 선택된 세그먼트에 따라 걸음수 제목 표시 (예: "오늘 걸음수")
                        Text(selectedSegment.stepTitle)
                            .font(.captionSemiBold12)
                            .foregroundStyle(.grayCaption02)
                    }
                    // 걸음수 숫자와 단위를 한 줄에 배치
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        // 걸음수 숫자, 큰 폰트
                        Text("\(viewModel.totalSteps.formatted())")
                            .font(.largeTitleSemiBold32)
                        // 단위 "걸음", 작은 폰트에 회색 스타일
                        Text(" 걸음")
                            .font(.calloutSemiBold14)
                            .foregroundStyle(.grayCaption02)
                    }
                }
            }
            
            // 현재 날짜 표시 (ex: 7월 25일)
            Text(formattedDate(viewModel.currentDate))
                .font(.captionSemiBold12)
                .foregroundColor(.grayCaption03)
        }
        .padding() // 전체 여백
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

// 날짜를 "M월 d일" 형태로 포맷하는 함수
private func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
    formatter.dateFormat = "M월 d일" // 원하는 포맷 지정
    return formatter.string(from: date)
}

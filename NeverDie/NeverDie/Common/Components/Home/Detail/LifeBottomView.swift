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
            .onChange(of: selectedSegment) {
                viewModel.selectedSegment = selectedSegment
            }
    }
    
    private var bottomView: some View {
        // 수명(저축된 시간) 정보 표시 영역
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                // 파란색 점 표시
                Circle()
                    .fill(Color.blue01)
                    .frame(width: 8, height: 8)
                
                // 선택된 세그먼트에 따른 수명 제목 표시 (예: 오늘 누적 수명)
                Text(selectedSegment.lifespanTitle)
                    .font(.sb14)
                    .foregroundStyle(.grayCaption03)
            }
            // 수명 숫자와 단위를 한 줄에 배치
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                // 수명(분) 숫자, 큰 폰트
                Text("\(Int(viewModel.totalSavedMinutes))")
                    .font(.sfB32)
                    .foregroundStyle(.black01)
                // 단위 "분", 작은 폰트에 회색 스타일
                Text("분")
                    .font(.sb16)
                    .foregroundStyle(.grayCaption03)
            }
        }
    }
}

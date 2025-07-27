//
//  SegmentsContainerView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/24/25.
//

import SwiftUI

struct SegmentsContainerView: View {
    
    @StateObject private var viewModel = StepChartsViewModel() // 차트 데이터와 상태를 관리하는 뷰모델
    @State private var selectedSegment: SegmentsModel = .day   // 선택된 세그먼트 (기본값은 '1일')

    var body: some View {
        ZStack {
            // 전체 배경색 (회색 톤) 적용
            Color(.grayBg)
                .ignoresSafeArea() // SafeArea까지 색상 확장

            VStack(spacing: 0) {
                // MARK: - 상단 네비게이션 바
                NavigationBar()
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)

                // MARK: - 본문 스크롤 영역
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        // MARK: - 상단 카드: 세그먼트 + 요약 정보 + 막대 차트
                        VStack(alignment: .leading, spacing: 16) {
                            SegmentsPickerView(selectedSegment: $selectedSegment)
                            StepTopView(selectedSegment: $selectedSegment)
                            BarChartsView(data: viewModel.hourlyStepData)
                        }
                        .padding(16) // 카드 내부 여백
                        .background(Color.white01)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 24)
                        
                        // MARK: - 중간 제목 텍스트
                        Text("누적 수명 추이")
                            .font(.b24)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)

                        // MARK: - 하단 카드: 수명 요약 + 라인 차트
                        VStack(alignment: .leading, spacing: 8) {
                            LifeBottomView(selectedSegment: $selectedSegment)
                            LineChartsView(data: viewModel.hourlyStepData)
                        }
                        .padding(16) // 흰 배경 내부 패딩
                        .background(Color.white01)
                        .cornerRadius(16)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .safeAreaPadding(.horizontal, 16)
    }
}

#Preview {
    SegmentsContainerView()
}

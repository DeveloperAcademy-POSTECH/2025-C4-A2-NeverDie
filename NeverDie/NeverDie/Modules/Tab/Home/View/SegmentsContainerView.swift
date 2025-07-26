//
//  SegmentsContainerView.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/24/25.
//

import SwiftUI

struct SegmentsContainerView: View {
    
    @StateObject private var viewModel = StepChartsViewModel()
    @State private var selectedSegment: SegmentsModel = .day

    var body: some View {
        ZStack {
            // 배경색을 화면 전체에 적용
            Color(.grayBg)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 항상 상단에 고정되는 네비게이션 바
                NavigationBar()
                    .padding(.bottom, 12)
                    .border(.red)
                
                // 아래부터 스크롤 영역
                ScrollView {
                    VStack(spacing: 20) { // Top 차트와 누적 수명 사이 Spacing
                        
                        // 상단 카드: 세그먼트 + 걸음수 + 바 차트
                        VStack(spacing: 0) {
                            SegmentsPickerView(selectedSegment: $selectedSegment)
                                .padding(.top, 10)
                            
                            VStack {
                                StepTopView(selectedSegment: $selectedSegment)
                                    .padding(.bottom, 0)
                            }
                            .border(.red)
                            BarChartsView(data: viewModel.hourlyStepData)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.white01)
                        .border(.red)
                        
                        // 중간 텍스트
                        Text("누적 수명 추이")
                            .font(.b24)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .border(.red)
                        
                        // 하단 카드: 수명 요약 + 라인 차트
                        VStack(spacing: 0) {
                            LifeBottomView(selectedSegment: $selectedSegment)
                            LineChartsView(data: viewModel.hourlyStepData)
                        }
                        .background(Color.white01)
                        .cornerRadius(16)
                        .border(.red)
                    }
                }
            }
        }
    }
}



#Preview {
    SegmentsContainerView()
}

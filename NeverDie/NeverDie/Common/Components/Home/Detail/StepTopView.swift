//
//  ChartsTop.swift
//  NeverDie
//
//  Created by 이혜빈 on 7/22/25.
//

import SwiftUI
import Charts

struct StepTopView: View {
    // 상위 뷰에서 선택된 세그먼트 값을 바인딩으로 받음
    @Binding var selectedSegment: SegmentsModel
    
    // 뷰모델 인스턴스를 상태 객체로 관리
    @ObservedObject var viewModel: StepChartsViewModel
    
    var body: some View {
        
        topView
        // selectedSegment가 변경될 때 뷰모델의 selectedSegment에 값 전달
            .onChange(of: selectedSegment) {
                viewModel.selectedSegment = selectedSegment
            }
    }
    
    // 실제 UI 구성 뷰
    private var topView: some View {
        VStack(alignment: .leading, spacing: 6) { // 걸음수와 날짜 사이
            HStack() {
                
                // 걸음수 정보 표시 영역
                VStack(alignment: .leading, spacing: 2) { // 총 걸음수와 걸음수 사이
                    HStack {
                        // 초록색 점 표시
                        Circle()
                            .fill(Color.green01)
                            .frame(width: 8, height: 8)
                        
                        // 선택된 세그먼트에 따라 걸음수 제목 표시 (예: "오늘 걸음수")
                        Text(selectedSegment.stepTitle)
                            .font(.sb14)
                            .foregroundStyle(.grayCaption03)
                    }
                    // 걸음수 숫자와 단위를 한 줄에 배치
                    HStack(alignment: .firstTextBaseline) {
                        // 걸음수 숫자, 큰 폰트
                        Text("\(viewModel.totalSteps.formatted())")
                            .font(.sfB32)
                            .foregroundStyle(.black01)
                        // 단위 "걸음", 작은 폰트에 회색 스타일
                        Text("걸음")
                            .font(.sb16)
                            .foregroundStyle(.grayCaption03)
                    }
                }
            }
            
            // 현재 날짜 표시 (ex: 7월 25일)
            Text(
                selectedSegment.dateRangeText(
                    from: viewModel.currentDate,
                    firstRecordDate: viewModel.firstRecordDate // 이건 뷰모델에 넣을 값
                )
            )
            .font(.sb14)
            .foregroundColor(.grayCaption03)

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

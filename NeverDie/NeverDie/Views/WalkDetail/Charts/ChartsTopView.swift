////
////  ChartsTop.swift
////  NeverDie
////
////  Created by 이혜빈 on 7/22/25.
////
//
//import SwiftUI
//import Charts
//
//struct ChartsTopView: View {
//    @StateObject private var viewModel = StepChartViewModel()
//    
//    var body: some View {
//        topView
//    }
//    
//    // MARK: 상단: 총 걸음 수 / 수명 ViewBuilder 함수로 변환
//    private var topView: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            
//            HStack(spacing: 70) {
//                // 걸음수
//                VStack(alignment: .leading, spacing: 10) {
//                    HStack {
//                        Circle()
//                            .fill(Color.greenChart02)
//                            .frame(width: 10, height: 10)
//                        Text("걸음수")
//                            .font(.captionSemiBold12)
//                            .foregroundStyle(.grayCaption02)
//                    }
//                    Text("\(viewModel.totalSteps.formatted())")
//                        .font(.largeTitleSemiBold32)
//                    + Text(" 걸음")
//                        .font(.calloutSemiBold14)
//                        .foregroundStyle(.grayCaption02)
//                }
//                
//                // 수명
//                VStack(alignment: .leading, spacing: 10) {
//                    HStack {
//                        Circle()
//                            .fill(Color.blue)
//                            .frame(width: 10, height: 10)
//                        Text("저축된 수명")
//                            .font(.captionSemiBold12)
//                            .foregroundStyle(.grayCaption02)
//                    }
//                    Text("\(Int(viewModel.totalSavedMinutes))")
//                        .font(.largeTitleSemiBold32)
//                    + Text(" 분")
//                        .font(.calloutSemiBold14)
//                        .foregroundStyle(.grayCaption02)
//                }
//                
//                Spacer()
//                
//            }
//            
//            // 오늘 날짜
//            Text(formattedDate(viewModel.currentDate))
//                .font(.captionSemiBold12)
//                .foregroundColor(.grayCaption03)
//            
//        }
//        
//    }
//}
//
//
//// 오늘 날짜 계산
//private func formattedDate(_ date: Date) -> String {
//    let formatter = DateFormatter()
//    formatter.locale = Locale(identifier: "ko_KR")
//    formatter.dateFormat = "M월 d일"
//    return formatter.string(from: date)
//}
//
//#Preview {
//    ChartsTopView()
//}

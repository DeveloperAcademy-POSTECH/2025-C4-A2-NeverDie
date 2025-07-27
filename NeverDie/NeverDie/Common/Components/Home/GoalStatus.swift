//
//  GoalStatusSummary.swift
//  NeverDie
//
//  Created by 길정수 on 7/26/25.
//

import SwiftUI

/// 진행률 막대의 길이를 유동적으로 계산하기 위한 함수
/// 퍼센트와 최대 길이(화면 가로 길이)를 받아서 해당 퍼센트의 길이를 계산
private func progressBarWidth(for percent: Int, maxWidth: CGFloat) -> CGFloat {
    let clampedPercent = max(0, min(percent, 100))
    return maxWidth * CGFloat(clampedPercent) / 100
}

struct GoalStatus: View {
    
    // MARK: - Property
    
    /// 이 목표에 해당하는 지표의 아이콘
    let icon: ImageResource
    
    /// 이 목표에 해당하는 지표 이름
    let title: String
    
    /// 몇 단계 목표인지
    let goalStage: Int
    
    /// 현재 상태(현재 걸음수, 현재 수면량 등)
    let currentStatus: Int
    
    /// 최종 목표(목표 걸음수, 목표 수면량 등)
    let goal: Int
    
    /// 몇 퍼센트 달성했는지
    let percent: Int
    
    /// 토글의 확장 여부를 상태로 관리
    @State var isExpanded: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 9) {
            HStack(spacing: 2) {
                Image(icon)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 19, height: 19)
                    .foregroundColor(Color.green01)

                Text(title)
                    .font(.b20)
                    .foregroundStyle(Color.black01)
                    .figmaLineHeight(fontSize: 20)
                
                Spacer()
                
                Button(action: {
                    isExpanded = !isExpanded
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.sfR16)
                        .foregroundStyle(Color.grayCaption02)
                        .figmaLineHeight(fontSize: 16)
                }
            }
            
            if isExpanded {
                detailContent
            } else {
                summaryContent
                    .padding(.top, 5)
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white01)
        )
        .animation(.easeInOut, value: isExpanded)
        .contextMenu {
            Button(role: .destructive, action: {
                print("🗑️ 목표 삭제 버튼 클릭")
            }) {
                Label("목표 삭제", systemImage: "xmark.bin")
            }
        }
    }
    
    // MARK: - GoalProgressBar
    /// 목표의 진행률을 나타내는 막대: %에 따라 유동적으로 나타남
    private func goalProgressBar(barHeight: CGFloat) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(height: barHeight)
                    .foregroundStyle(Color.grayCaption00)
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: progressBarWidth(for: percent, maxWidth: geometry.size.width), height: barHeight)
                    .foregroundStyle(Color.green01)
            }
        }
        .frame(height: barHeight)
    }
    
    // MARK: - SummaryContent
    /// 접혀있을 때 내용
    private var summaryContent: some View {
        VStack(spacing: 5) { /// 하나의 HStack과 진행률 막대
            /// HStack
            HStack(spacing: 4) {
                Text("목표 \(goalStage)단계")
                    .font(.sb16)
                    .foregroundStyle(Color.black01)
                    .figmaLineHeight(fontSize: 16)
                
                Text("\(currentStatus)/\(goal)")
                    .font(.m16)
                    .foregroundStyle(Color.grayCaption02)
                    .figmaLineHeight(fontSize: 16)
                
                Spacer()
                
                Text("\(percent)%")
                    .font(.b24)
                    .foregroundStyle(Color.black01)
                    .figmaLineHeight(fontSize: 24)
            }
            
            /// 진행률 막대
            goalProgressBar(barHeight: 12)
        }
    }
    
    // MARK: - DetailContent
    /// 펼쳐졌을 때 내용
    private var detailContent: some View {
        VStack(spacing: 12) { /// 두 개의 HStack 포함
            /// 첫 번째 HStack
            HStack(alignment: .bottom) {
                StepCountGoalChart()
                    .padding(.top, 30)
                    .padding(.bottom, 8)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: -2) {
                    Text("오늘 걸음 수")
                        .font(.sb14)
                        .foregroundStyle(Color.grayCaption03)
                        .figmaLineHeight(fontSize: 14)
                    
                    HStack(spacing: 2) {
                        Text("\(currentStatus)")
                            .font(.sfB32)
                            .figmaLineHeight(fontSize: 32)
                        
                        Text("걸음")
                            .font(.sb16)
                            .figmaLineHeight(fontSize: 16)
                    }
                }
            }
            
            /// 두 번째 HStack
            HStack(spacing: 8) {
                Text("목표 \(goalStage)단계")
                    .font(.m16)
                    .foregroundStyle(Color.grayCaption03)
                    .figmaLineHeight(fontSize: 16)
                
                goalProgressBar(barHeight: 8)
                
                Text("\(percent)%")
                    .font(.m16)
                    .foregroundStyle(Color.grayCaption03)
                    .figmaLineHeight(fontSize: 16)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    GoalStatus(icon: ImageResource.stepCountIcon, title: "걸음수", goalStage: 3, currentStatus: 10521, goal: 13000, percent: 80)
}

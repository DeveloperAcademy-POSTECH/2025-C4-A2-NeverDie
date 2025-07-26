//
//  GoalStatusSummary.swift
//  NeverDie
//
//  Created by 길정수 on 7/26/25.
//

import SwiftUI

private func progressBarWidth(for percent: Int, maxWidth: CGFloat) -> CGFloat {
    let clampedPercent = max(0, min(percent, 100))
    return maxWidth * CGFloat(clampedPercent) / 100
}

struct GoalStatus: View {
    let sectionIcon: ImageResource
    let sectionTitle: String
    let goalStage: Int
    let currentStatus: Int
    let goal: Int
    let percent: Int
    
    @State var isExpanded: Bool = true
    
    var body: some View {
        VStack(spacing: 9) {
            HStack(spacing: 2) {
                Image(sectionIcon)
                    .resizable()
                    .frame(width: 10, height: 15)
                
                Text(sectionTitle)
                    .font(.b20)
                    .foregroundStyle(Color.black01)
                
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
                DetailContent
            } else {
                SummaryContent
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
    }
    
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
    
    private var SummaryContent: some View {
        VStack(spacing: 5) {
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
            
            goalProgressBar(barHeight: 12)
        }
    }
    
    private var DetailContent: some View {
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
                    
                    HStack(spacing: 2) {
                        Text("\(currentStatus)")
                            .font(.sfB32)
                        Text("걸음")
                            .font(.sb16)
                    }
                }
            }
            
            /// 두 번째 HStack
            HStack(spacing: 8) {
                Text("목표 \(goalStage)단계")
                    .font(.m16)
                    .foregroundStyle(Color.grayCaption03)
                
                goalProgressBar(barHeight: 8)
                
                Text("\(percent)%")
                    .font(.m16)
                    .foregroundStyle(Color.grayCaption03)
            }
        }
    }
}


#Preview {
    GoalStatus(sectionIcon: ImageResource.stepCountIcon, sectionTitle: "걸음수", goalStage: 3, currentStatus: 10521, goal: 13000, percent: 80)
}

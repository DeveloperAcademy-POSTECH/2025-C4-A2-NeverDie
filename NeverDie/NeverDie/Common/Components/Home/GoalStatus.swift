//
//  GoalStatusSummary.swift
//  NeverDie
//
//  Created by 길정수 on 7/26/25.
//

import SwiftUI

struct GoalStatus: View {
    
    // MARK: - Property
    
    /// 이 목표에 해당하는 지표의 아이콘
    let icon: ImageResource
    
    /// 이 목표에 해당하는 지표 이름
    let title: String
    
    /// 몇 단계 목표인지
    let goalStage: Int
    
    /// 걸음수 정보 (차트에 전달)
    let walkingSessions: [WalkingSession]
    
    /// 토글의 확장 여부를 상태로 관리
    @State var isExpanded: Bool = false
    
    /// `goalStage`에 해당하는 실제 목표값을 goalInfoList에서 찾아 반환
    private var goal: Int {
        // goalInfoList에서 title과 일치하는 IndicatorData를 찾음
        guard let indicator = goalInfoList.first(where: { $0.text == title }) else {
            return 0
        }
        // 해당 indicator의 stages에서 goalStage에 맞는 stageGoal 찾기
        return indicator.stages.first(where: { $0.stageNum == goalStage })?.stageGoal ?? 0
    }
    
    /// 가장 최근 걸음 수 (최근 날짜의 걸음 수)
    private var currentStatus: Int {
        walkingSessions
            .sorted { $0.date < $1.date }
            .last?.stepCount ?? 0
    }
    
    /// 목표 대비 진행률(%) 계산
    private var percent: Int {
        guard goal > 0 else { return 0 }
        let ratio = Double(currentStatus) / Double(goal)
        return min(Int(ratio * 100), 100)  // 100% 초과 방지
    }
    
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
            GoalProgressBar(barHeight: 12, percent: percent)
        }
    }
    
    // MARK: - DetailContent
    /// 펼쳐졌을 때 내용
    private var detailContent: some View {
        VStack(spacing: 12) { /// 두 개의 HStack 포함
            /// 첫 번째 HStack
            HStack(alignment: .bottom) {
                StepCountGoalChart(walkingSessions: walkingSessions)
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
                
                GoalProgressBar(barHeight: 8, percent: percent)
                
                Text("\(percent)%")
                    .font(.m16)
                    .foregroundStyle(Color.grayCaption03)
                    .figmaLineHeight(fontSize: 16)
            }
        }
    }
}

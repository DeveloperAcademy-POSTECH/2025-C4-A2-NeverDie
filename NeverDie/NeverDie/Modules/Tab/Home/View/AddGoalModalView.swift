//
//  AddGoalModalView.swift
//  NeverDie
//
//  Created by 길정수 on 7/27/25.
//

import SwiftUI

// 단계 정보
struct StageData: Identifiable {
    let id = UUID()
    let stageNum: Int
    let stageContent: String
}

// 지표별 데이터
struct IndicatorData: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let text: String
    let stages: [StageData]
}

// 전체 데이터
let goalInfoList: [IndicatorData] = [
    IndicatorData(
        icon: .stepCountIcon,
        text: "걸음수",
        stages: [
            StageData(stageNum: 1, stageContent: "하루에 4,000걸음 걷기"),
            StageData(stageNum: 2, stageContent: "하루에 8,000걸음 걷기"),
            StageData(stageNum: 3, stageContent: "하루에 13,000걸음 걷기")
        ]
    )
]

struct AddGoalModalView: View {
    @State private var selectedIndicatorID: UUID? = goalInfoList.first?.id
    @State private var selectedStageID: UUID?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                modalHeader
                modalContents
                    .padding(.top, 28)
                    .background(Color.grayBg)
            }
            
            MainColorButton(text: "저장하기", action: {
                print("저장하기 클릭")
            })
        }
        .safeAreaPadding(.horizontal, 16)
    }
    
    private var modalHeader: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.grayCaption01)
                .frame(width: 48, height: 4)
            
            Text("목표 설정")
                .font(.b20)
                .foregroundStyle(Color.black01)
                .figmaLineHeight(fontSize: 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 11)
        .background(Color.white01)
    }
    
    private var modalContents: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("원하는 지표의 목표를 설정해주세요")
                    .font(.sb14)
                    .foregroundStyle(Color.grayCaption03)
                    .figmaLineHeight(fontSize: 14)
                    .padding(.bottom, 4)
                
                /// 지표 선택 — 선택 가능한 모든 지표를 ForEach로 표시
                VStack(alignment: .leading, spacing: 8) {
                    Text("지표")
                        .font(.sb16)
                        .foregroundStyle(Color.grayCaption03)
                        .figmaLineHeight(fontSize: 16)
                    
                    HStack(spacing: 5) {
                        ForEach(goalInfoList, id: \.id) { goalInfo in
                            GoalIndicatorCard(icon: goalInfo.icon, text: goalInfo.text, isSelected: selectedIndicatorID == goalInfo.id) {
                                selectedIndicatorID = goalInfo.id
                                selectedStageID = nil
                            }
                        }
                    }
                }
                
                /// 목표 난이도 (단계) 선택 — 선택된 지표에 따라서 ForEach로 표시
                if let selected = goalInfoList.first(where: { $0.id == selectedIndicatorID }) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("목표 난이도")
                            .font(.sb16)
                            .foregroundStyle(Color.grayCaption03)
                            .figmaLineHeight(fontSize: 16)
                        
                        VStack(spacing: 12) {
                            ForEach(selected.stages) { stage in
                                GoalStageCard(
                                    stageNum: stage.stageNum,
                                    stageContent: stage.stageContent,
                                    isSelected: selectedStageID == stage.id
                                ) {
                                    selectedStageID = stage.id
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddGoalModalView()
}

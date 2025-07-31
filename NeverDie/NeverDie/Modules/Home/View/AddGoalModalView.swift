//
//  AddGoalModalView.swift
//  NeverDie
//
//  Created by 길정수 on 7/27/25.
//

import SwiftUI

struct AddGoalModalView: View {
    
    // MARK: - Property
    
    /// 선택된 지표를 저장
    @State private var selectedIndicatorID: UUID? = goalInfoList.first?.id
    
    /// 선택된 목표를 저장
    @State private var selectedStageID: UUID?
    
    /// 앱스토리지에 저장할 UUID 문자열
    @AppStorage("selectedStageUUID") private var selectedStageUUID: String?
    
    /// 모달 닫기용
    @Environment(\.dismiss) private var dismiss
    
    
    // 저장 후 모달 닫기
    private func saveSelectionAndDismiss() {
        guard let selectedID = selectedStageID else {
            // 선택된 목표가 없으면 저장하지 않고 그냥 닫거나, 필요시 알림 처리 가능
            dismiss()
            return
        }
        
        // 앱스토리지에 저장
        selectedStageUUID = selectedID.uuidString
        print("저장 완료: \(selectedStageUUID ?? "")")
        
        // 모달 닫기
        dismiss()
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                modalHeader
                modalContents
                    .padding(.top, 28)
            }
            .background(Color.grayBg)
            
            MainColorButton(text: "저장하기", action: {
                saveSelectionAndDismiss()
            })
        }
        .safeAreaPadding(.horizontal, 16)
    }
    
    // MARK: - ModalHeader
    /// 헤더: 인디케이터 + 타이틀
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
    
    // MARK: - ModalContents
    /// 내용: '지표'를 ForEach로 나열, 선택된 지표에 해당하는 '목표 난이도' 나열
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

// MARK: - Preview
#Preview {
    AddGoalModalView()
}

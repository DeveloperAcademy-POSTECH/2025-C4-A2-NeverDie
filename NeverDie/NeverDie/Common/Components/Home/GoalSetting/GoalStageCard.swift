//
//  GoalStageCard.swift
//  NeverDie
//
//  Created by 길정수 on 7/27/25.
//

import SwiftUI

struct GoalStageCard: View {
    
    // MARK: - Property
    
    /// 몇 단계인지 (1, 2, 3 등)
    let stageNum: Int
    
    /// 단계의 내용
    let stageContent: String
    
    /// 이 단계가 선택되었는지 여부
    let isSelected: Bool
    
    /// 해당 단계를 클릭했을 때의 액션
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            HStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.sfR24)
                    .foregroundColor(isSelected ? Color.blue01 : Color.grayCaption00)
                    .figmaLineHeight(fontSize: 24)

                VStack(alignment: .leading, spacing: 5) {
                    Text("\(stageNum)단계")
                        .font(.b20)
                        .foregroundStyle(Color.black01)
                        .figmaLineHeight(fontSize: 20)
                    
                    Text("\(stageContent)")
                        .font(.m16)
                        .foregroundStyle(Color.grayCaption02)
                        .figmaLineHeight(fontSize: 16)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 20)
            .padding(.horizontal, 24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white01)
                    .stroke(isSelected ? Color.blue01 : Color.clear, lineWidth: 1.5)
            )
        }
    }
}

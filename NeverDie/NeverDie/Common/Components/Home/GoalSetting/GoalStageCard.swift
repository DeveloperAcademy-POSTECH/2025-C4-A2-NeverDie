//
//  GoalStageCard.swift
//  NeverDie
//
//  Created by 길정수 on 7/27/25.
//

import SwiftUI

struct GoalStageCard: View {
    let stageNum: Int
    let stageContent: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.sfR24)
                    .foregroundColor(isSelected ? Color.blue01 : Color.grayCaption00)

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

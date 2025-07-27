//
//  GoalIndicatorCard.swift
//  NeverDie
//
//  Created by 길정수 on 7/27/25.
//

import SwiftUI

struct GoalIndicatorCard: View {
    
    // MARK: - Property
    
    /// 지표(걸음수, 수면 등)에 해당하는 아이콘
    let icon: ImageResource
    
    /// 지표 이름(걸음수, 수면 등)
    let text: String
    
    /// 해당 지표가 선택되었는지 여부
    let isSelected: Bool
    
    /// 해당 지표를 클릭했을 때의 액션
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(icon)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isSelected ? Color.blue01 : Color.grayCaption02)
                
                Text(text)
                    .font(.sb16)
                    .foregroundStyle(Color.black01)
                    .figmaLineHeight(fontSize: 16)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white01)
                    .stroke(isSelected ? Color.blue01 : Color.clear, lineWidth: 1.5)
            )
        }
    }
}

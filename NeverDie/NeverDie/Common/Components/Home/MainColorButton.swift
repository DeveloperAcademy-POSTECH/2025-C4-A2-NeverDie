//
//  MainColorButton.swift
//  NeverDie
//
//  Created by 길정수 on 7/27/25.
//

import SwiftUI

struct MainColorButton: View {
    
    // MARK: - Property
    
    /// 버튼에 들어갈 텍스트
    let text: String
    
    /// 버튼의 동작
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.b20)
                .foregroundStyle(Color.white01)
                .figmaLineHeight(fontSize: 20)
                .padding(.vertical, 17)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.blue01)
                )
        }
    }
}

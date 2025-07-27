//
//  MainColorButton.swift
//  NeverDie
//
//  Created by 길정수 on 7/27/25.
//

import SwiftUI

struct MainColorButton: View {
    let text: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.b20)
                .foregroundStyle(Color.white01)
                .padding(.vertical, 17)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.blue01)
                )
        }
    }
}

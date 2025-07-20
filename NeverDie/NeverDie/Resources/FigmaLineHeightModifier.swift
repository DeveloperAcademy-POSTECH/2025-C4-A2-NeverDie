//
//  FigmaLineHeightModifier.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import SwiftUI

struct FigmaLineHeightModifier: ViewModifier {
    let fontSize: CGFloat
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        let extraSpace = lineHeight - fontSize
        let verticalPadding = max(extraSpace / 2, 0)
        return content
            .font(.system(size: fontSize))
            .padding(.vertical, verticalPadding)
    }
}

extension View {
    func figmaLineHeight(fontSize: CGFloat, lineHeight: CGFloat) -> some View {
        self.modifier(FigmaLineHeightModifier(fontSize: fontSize, lineHeight: lineHeight))
    }
}


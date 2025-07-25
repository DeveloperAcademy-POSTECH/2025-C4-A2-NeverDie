//
//  FigmaLineHeightModifier.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import SwiftUI

struct FigmaLineHeightModifier: ViewModifier {
    let fontSize: CGFloat
    let figmaLineHeight: CGFloat

    var font: UIFont { .systemFont(ofSize: fontSize) }
    var swiftUILineHeight: CGFloat { font.lineHeight }
    var lineSpacing: CGFloat { max(figmaLineHeight - swiftUILineHeight, 0) }
    var verticalPadding: CGFloat { max((figmaLineHeight - swiftUILineHeight) / 2, 0) }

    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize))
            .lineSpacing(lineSpacing)
            .padding(.vertical, verticalPadding)
    }
}
extension View {
    func figmaLineHeight(fontSize: CGFloat, lineHeight: CGFloat? = nil) -> some View {
        let lh = lineHeight ?? fontSize * 1.3
        return self.modifier(FigmaLineHeightModifier(fontSize: fontSize, figmaLineHeight: lh))
    }
}

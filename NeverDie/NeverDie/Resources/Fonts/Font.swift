//
//  Font.swift
//  NeverDie
//
//  Created by 길정수 on 7/20/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretendard {
        case extraBold
        case semiBold
        case bold
        case regular
        case medium
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "PretendardVariable-ExtraBold"
            case .semiBold:
                return "PretendardVariable-SemiBold"
            case .bold:
                return "PretendardVariable-Bold"
            case .regular:
                return "PretendardVariable-Regular"
            case .medium:
                return "PretendardVariable-Medium"
            case .light:
                return "PretendardVariable-Light"
            }
        }
    }
    
    static func pretendard(type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    // MARK: - Bold
    static var largeTitleBold40: Font {
        return .pretendard(type: .bold, size: 40)
    }
    
    static var titleBold28: Font {
        return .pretendard(type: .bold, size: 28)
    }
    
    static var headlineBold24: Font {
        return .pretendard(type: .bold, size: 24)
    }
    
    static var calloutBold16: Font {
        return .pretendard(type: .bold, size: 16)
    }
    
    static var calloutBold14: Font {
        return .pretendard(type: .bold, size: 14)
    }
    
    // MARK: - SemiBold
    static var largeTitleSemiBold32: Font {
        return .pretendard(type: .semiBold, size: 32)
    }
    
    static var titleSemiBold28: Font {
        return .pretendard(type: .semiBold, size: 28)
    }
    
    static var subheadlineSemiBold20: Font {
        return .pretendard(type: .semiBold, size: 20)
    }
    
    static var navLabelSemiBold17: Font {
        return .pretendard(type: .semiBold, size: 17)
    }
    
    static var labelSemiBold16: Font {
        return .pretendard(type: .semiBold, size: 16)
    }
    
    static var calloutSemiBold14: Font {
        return .pretendard(type: .semiBold, size: 14)
    }
    
    static var segmenLabelSemiBold13: Font {
        return .pretendard(type: .semiBold, size: 13)
    }
    
    static var captionSemiBold12: Font {
        return .pretendard(type: .semiBold, size: 12)
    }
    
    // MARK: - Regular
    
    static var navLabelRegular17: Font {
        return .pretendard(type: .regular, size: 17)
    }
    
    static var captionRegular13: Font {
        return .pretendard(type: .regular, size: 13)
    }
    
    static var segmentLabelRegular13: Font {
        return .pretendard(type: .regular, size: 13)
    }
    
    static var footnoteRegular11: Font {
        return .pretendard(type: .regular, size: 11)
    }
    
    // MARK: - Medium
    static var subheadlineMedium18: Font {
        return .pretendard(type: .medium, size: 18)
    }
    
    static var captionMedium16: Font {
        return .pretendard(type: .medium, size: 16)
    }
    
    static var captionMedium12: Font {
        return .pretendard(type: .medium, size: 12)
    }
    
    static var captionMedium08: Font {
        return .pretendard(type: .medium, size: 8)
    }
}

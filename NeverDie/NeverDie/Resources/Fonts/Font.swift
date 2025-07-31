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
    
    enum Suit {
        case heavy
        
        var value: String {
            switch self {
            case .heavy:
                return "SUIT-Heavy"
            }
        }
    }
    
    enum SfPro {
        case bold
        case regular
        
        var weight: Font.Weight {
            switch self {
            case .bold: return .bold
            case .regular: return .regular
            }
        }
    }
    
    static func pretendard(type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static func suit(type: Suit, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static func sfPro(type: SfPro, size: CGFloat) -> Font {
        return .system(size: size, weight: type.weight)
    }
    
    // MARK: - NEW FONT
    
    static var b24: Font {
        return .pretendard(type: .bold, size: 24)
    }
    
    static var b20: Font {
        return .pretendard(type: .bold, size: 20)
    }
    
    static var sb16: Font {
        return .pretendard(type: .semiBold, size: 16)
    }
    
    static var sb14: Font {
        return .pretendard(type: .semiBold, size: 14)
    }
    
    static var r16: Font {
        return .pretendard(type: .regular, size: 16)
    }
    
    static var r14: Font {
        return .pretendard(type: .regular, size: 14)
    }
    
    static var r10: Font {
        return .pretendard(type: .regular, size: 10)
    }
    
    static var m16: Font {
        return .pretendard(type: .medium, size: 16)
    }
    
    static var m12: Font {
        return .pretendard(type: .medium, size: 12)
    }
    
    static var suitH40: Font {
        return .suit(type: .heavy, size: 40)
    }
    
    static var sfB32: Font {
        return .sfPro(type: .bold, size: 32)
    }
    
    static var sfR24: Font {
        return .sfPro(type: .regular, size: 24)
    }
    static var sfR16: Font {
        return .sfPro(type: .regular, size: 16)
    }
}

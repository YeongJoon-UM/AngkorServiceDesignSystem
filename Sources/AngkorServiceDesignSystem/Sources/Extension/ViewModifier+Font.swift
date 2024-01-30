//
//  ViewModifier+Font.swift
//  AngkorChat
//
//  Created by 정영준 on 2024/01/22.
//

import SwiftUI

private struct ASDSFontName {
    static let kantumruyProRegular = "KantumruyPro-Regular"
    static let kantumruyProMedium = "KantumruyPro-Medium"
    
    static var all: [String] { [kantumruyProRegular, kantumruyProMedium] }
}

public struct ASDSFonts {
    public static func registerASDSFonts() {
        ASDSFontName.all.forEach { font in
            guard let url = Bundle.module.url(forResource: font, withExtension: "ttf") else { return }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}

public extension View {
    /// Attach this to any Xcode Preview's view to have custom fonts displayed
    /// Note: Not needed for the actual app
    func loadCustomFonts() -> some View {
        ASDSFonts.registerASDSFonts()
        return self
    }
}

public struct ASDSFontModifier: ViewModifier {
    var font: ASDSFontType
    var color: Color
    
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .font(.custom(font.isMedium ? ASDSFontName.kantumruyProMedium : ASDSFontName.kantumruyProRegular, size: font.size))
                .foregroundColor(color)
                .kerning((font != .BodyXsmall || font != .Caption) ? font.size * -0.03 : 0)
                .lineSpacing(font.lineSpacing())
                .padding(.vertical, (font.lineSpacing() / 2))
        } else {
            content
                .font(.custom(font.isMedium ? ASDSFontName.kantumruyProMedium : ASDSFontName.kantumruyProRegular, size: font.size))
                .foregroundColor(color)
                .lineSpacing(font.lineSpacing())
                .padding(.vertical, (font.lineSpacing() / 2))
        }
    }
}

extension View {
    public func ASDSFont(_ font: ASDSFontType, color: Color = Color.ASDS.labelPrimary) -> some View {
        self.modifier(ASDSFontModifier(font: font, color: color))
    }
}

public enum ASDSFontType {
    /// Size: 32 - Wieght: Medium
    case H1
    /// Size: 28 - Wieght: Medium
    case H2
    /// Size: 24 - Wieght: Medium
    case H3
    /// Size: 20 - Wieght: Medium
    case H4
    /// Size: 18 - Wieght: Medium
    case H5
    /// Size: 16 - Wieght: Medium
    case H6
    /// Size: 14 - Wieght: Medium
    case H7
    /// Size: 12 - Wieght: Medium
    case H8
    /// Size: 18 - Wieght: Regular
    case BodyLarge
    /// Size: 16 - Wieght: Regular
    case BodyMedium
    /// Size: 14 - Wieght: Regular
    case BodySmall
    /// Size: 12 - Wieght: Regular - LineHeight: 18
    case BodyXsmall
    /// Size: 12 - Wieght: Regular - LineHeight: 16
    case Caption
    
    var size: CGFloat {
        switch self {
        case .H1:
            return 32
        case .H2:
            return 28
        case .H3:
            return 24
        case .H4:
            return 20
        case .H5:
            return 18
        case .H6:
            return 16
        case .H7:
            return 14
        case .H8:
            return 12
        case .BodyLarge:
            return 18
        case .BodyMedium:
            return 16
        case .BodySmall:
            return 14
        case .BodyXsmall:
            return 12
        case .Caption:
            return 12
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .H1:
            return 44
        case .H2:
            return 40
        case .H3:
            return 34
        case .H4:
            return 30
        case .H5:
            return 26
        case .H6:
            return 24
        case .H7:
            return 20
        case .H8:
            return 18
        case .BodyLarge:
            return 26
        case .BodyMedium:
            return 24
        case .BodySmall:
            return 20
        case .BodyXsmall:
            return 18
        case .Caption:
            return 16
        }
    }
    
    func lineSpacing() -> CGFloat {
        return self.lineHeight - self.size
    }
    
    var isMedium: Bool {
        switch self {
        case .H1:
            return true
        case .H2:
            return true
        case .H3:
            return true
        case .H4:
            return true
        case .H5:
            return true
        case .H6:
            return true
        case .H7:
            return true
        case .H8:
            return true
        case .BodyLarge:
            return false
        case .BodyMedium:
            return false
        case .BodySmall:
            return false
        case .BodyXsmall:
            return false
        case .Caption:
            return false
        }
    }
}

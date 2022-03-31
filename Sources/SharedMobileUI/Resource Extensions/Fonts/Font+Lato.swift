//
//  Font+Lato.swift
//
//  Copyright © 2019-2021 Sage Bionetworks. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1.  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2.  Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// 3.  Neither the name of the copyright holder(s) nor the names of any contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission. No license is granted to the trademarks of
// the copyright holders even if such marks are included in this software.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

extension UIFont {
    public static func latoFont(_ size: CGFloat, relativeTo textStyle: UIFont.TextStyle? = nil, weight: UIFont.Weight = .regular) -> UIFont {
        let fontName = FontWrapper.shared.fontName(weight)
        if let textStyle = textStyle,
           let customFont = UIFont(name: fontName, size: size) {
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
        }
        else {
            return .init(name: fontName, size: size) ?? .systemFont(ofSize: size, weight: weight)
        }
    }
}
#endif

extension Font {
    
    /// Returns the most appropriate Lato font found by the system. This will first check for the
    /// Lato font that matches the requested weight. If not found (because this framework only
    /// includes a subset of the full Lato font family), then it will fall back to the most
    /// appropriate font registered from this framework.
    ///
    /// This framework does not include all the possible sizes and weights for the Lato font
    /// because the full font family is about 11 mb.
    ///
    /// - parameters:
    ///     - size: The size of the font requested.
    ///     - weight: The weight of the font requested.
    /// - returns: The closest font to the one requested that is registered for this application.
    public static func latoFont(fixedSize size: CGFloat, weight: Font.Weight = .regular) -> Font {
        latoFont(size, relativeTo: nil, weight: weight)
    }
    
    /// Returns the most appropriate Lato font found by the system. This will first check for the
    /// Lato font that matches the requested weight. If not found (because this framework only
    /// includes a subset of the full Lato font family), then it will fall back to the most
    /// appropriate font registered from this framework.
    ///
    /// This framework does not include all the possible sizes and weights for the Lato font
    /// because the full font family is about 11 mb.
    ///
    /// - parameters:
    ///     - size: The size of the font requested.
    ///     - textSyle: The relative text style for the text.
    ///     - weight: The weight of the font requested.
    /// - returns: The closest font to the one requested that is registered for this application.
    public static func latoFont(_ size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil, weight: Font.Weight = .regular) -> Font {
        let fontName = FontWrapper.shared.fontName(weight)
        if #available(iOS 14.0, *) {
            if let textStyle = textStyle {
                return .custom(fontName, size: size, relativeTo: textStyle)
            }
            else {
                return .custom(fontName, fixedSize: size)
            }
        } else {
            return .custom(fontName, size: size)
        }
    }
    
    /// Returns the Lato italic font embedded in this framework.
    /// - seealso: `latoFont()`
    public static func italicLatoFont(_ size: CGFloat, relativeTo textStyle: Font.TextStyle? = nil, weight: Font.Weight = .regular) -> Font {
        let fontName = FontWrapper.shared.italicFontName(weight)
        if #available(iOS 14.0, *) {
            if let textStyle = textStyle {
                return .custom(fontName, size: size, relativeTo: textStyle)
            }
            else {
                return .custom(fontName, fixedSize: size)
            }
        } else {
            return .custom(fontName, size: size)
        }
    }
}

/// The wrapper is used here to register the Lato fonts once only.
fileprivate class FontWrapper {
    
    static let shared = FontWrapper()
    
    private init() {
        let bundle = Bundle.module
        Font.registerFont(filename: "Lato-Bold.ttf", bundle: bundle)
        Font.registerFont(filename: "Lato-BoldItalic.ttf", bundle: bundle)
        Font.registerFont(filename: "Lato-Regular.ttf", bundle: bundle)
        Font.registerFont(filename: "Lato-Italic.ttf", bundle: bundle)
    }
    
    #if canImport(UIKit)
    
    func fontName(_ weight: UIFont.Weight) -> String {
        switch weight {
        case .ultraLight, .thin, .light:
            return "Lato-Regular"
        case .semibold, .heavy, .bold, .black:
            return "Lato-Bold"
        default:
            return Font.isBoldTextEnabled ? "Lato-Bold" : "Lato-Regular"
        }
    }
    
    #endif
    
    func fontName(_ weight: Font.Weight) -> String {
        switch weight {
        case .ultraLight, .thin, .light:
            return "Lato-Regular"
        case .semibold, .heavy, .bold, .black:
            return "Lato-Bold"
        default:
            return Font.isBoldTextEnabled ? "Lato-Bold" : "Lato-Regular"
        }
    }
        
    func italicFontName(_ weight: Font.Weight) -> String {
        switch weight {
        case .ultraLight, .thin, .light:
            return "Lato-Italic"
        case .semibold, .heavy, .bold, .black:
            return "Lato-BoldItalic"
        default:
            return Font.isBoldTextEnabled ? "Lato-BoldItalic" : "Lato-Italic"
        }
    }
}


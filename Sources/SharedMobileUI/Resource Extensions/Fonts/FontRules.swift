//
//  FontRules.swift
//
//  Copyright © 2021 Sage Bionetworks. All rights reserved.
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

public protocol FontRules {
    
    var maxSupportedHeaderLevel: Int { get }
    func headerFont(at level: Int) -> Font
    
    var maxSupportedBodyLevel: Int { get }
    func bodyFont(at level: Int, isEmphasis: Bool) -> Font
    
    var maxSupportedButtonLevel: Int { get }
    func buttonFont(at level: Int, isSelected: Bool) -> Font
    func buttonColor(at level: Int, isSelected: Bool) -> Color
}

public final class DesignSystem {
    public static var fontRules : FontRules = DefaultFontRules()
}

fileprivate enum HeaderLevel: Int, CaseIterable {
    case h1 = 1, h2, h3, h4, h5, h6, h7
}

fileprivate enum BodyLevel: Int, CaseIterable {
    case body1 = 1, body2
}

fileprivate enum ButtonLevel: Int, CaseIterable {
    case button1 = 1, button2
}

struct DefaultFontRules : FontRules {
    
    var maxSupportedHeaderLevel: Int { HeaderLevel.allCases.count }
    
    func headerFont(at level: Int) -> Font {
        switch HeaderLevel(rawValue: level) {
        case .h1:
            return .playfairDisplayFont(21, relativeTo: .largeTitle)
        case .h2:
            return .playfairDisplayFont(18, relativeTo: .largeTitle)
        case .h3:
            return .latoFont(24, relativeTo: .title, weight: .bold)
        case .h4:
            return .latoFont(18, relativeTo: .title, weight: .bold)
        case .h5:
            return .latoFont(16, relativeTo: .title2, weight: .bold)
        case .h6:
            return .poppinsFont(14, relativeTo: .title3, weight: .medium)
        case .h7:
            return .poppinsFont(12, relativeTo: .title3, weight: .medium)
        case .none:
            debugPrint("WARNING: Level \(level) headers are not supported by this FontRules.")
            return .poppinsFont(12, relativeTo: .title3, weight: .medium)
        }
    }
    
    var maxSupportedBodyLevel: Int { BodyLevel.allCases.count }
    
    func bodyFont(at level: Int, isEmphasis: Bool) -> Font {
        let weight: Font.Weight = Font.isBoldTextEnabled || isEmphasis ? .bold : .medium
        let fontSize: CGFloat = {
            switch BodyLevel(rawValue: level) {
            case .body1:
                return 16
            case .body2:
                return 14
            case .none:
                debugPrint("WARNING: Level \(level) body are not supported by this FontRules.")
                return 14
            }
        }()
        if Font.isBoldTextEnabled && isEmphasis {
            return .italicLatoFont(fontSize, relativeTo: .body, weight: weight)
        }
        else {
            return .latoFont(fontSize, relativeTo: .body, weight: weight)
        }
    }
    
    var maxSupportedButtonLevel: Int { ButtonLevel.allCases.count }
    
    func buttonFont(at level: Int, isSelected: Bool) -> Font {
        switch ButtonLevel(rawValue: level) {
        case .button1:
            return .latoFont(20, relativeTo: .largeTitle, weight: .bold)
        case .button2:
            return .latoFont(fixedSize: 12, weight: isSelected ? .medium : .bold)
        case .none:
            debugPrint("WARNING: Level \(level) buttons are not supported by this FontRules.")
            return .latoFont(fixedSize: 10, weight: isSelected ? .medium : .bold)
        }
    }
    
    func buttonColor(at level: Int, isSelected: Bool) -> Color {
        if isSelected && ButtonLevel(rawValue: level) == .button2 && Font.isBoldTextEnabled {
            return .textLinkColor
        }
        else {
            return .textForeground
        }
    }
}

//
//  Color+Custom.swift
//
//  Copyright © 2017-2021 Sage Bionetworks. All rights reserved.
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

#if os(macOS)
import AppKit
fileprivate typealias TypedColor = NSColor
#else
import UIKit
fileprivate typealias TypedColor = UIColor
#endif

extension Color {
    
    // Named colors
    public static let sageBlack: Color = .init("sageBlack", bundle: .module)
    public static let sageWhite: Color = .init("sageWhite", bundle: .module)
    public static let screenBackground: Color = .init("screenBackground", bundle: .module)
    public static let textForeground: Color = .init("textForeground", bundle: .module)
    
    // App colors
    public static let textLinkColor: Color = {
        if let _ = TypedColor.init(named: "LinkColor") {
            return .init("LinkColor")
        }
        else {
            return .accentColor
        }
    }()
    
    // Shades of gray
    public static let hex2A2A2A: Color = .init("#2A2A2A", bundle: .module)
    public static let hex727272: Color = .init("#727272", bundle: .module)
    public static let hexB8B8B8: Color = .init("#B8B8B8", bundle: .module)
    public static let hexDEDEDE: Color = .init("#DEDEDE", bundle: .module)
    public static let hexDFDFDF: Color = .init("#DFDFDF", bundle: .module)
    public static let hexE5E5E5: Color = .init("#E5E5E5", bundle: .module)
    public static let hexF0F0F0: Color = .init("#F0F0F0", bundle: .module)
    public static let hexFDFDFD: Color = .init("#FDFDFD", bundle: .module)
    
    /// Initialize with the hex color.
    public init?(hex: String) {
        let hexString = hex.hasPrefix("#") || hex.hasPrefix("0x") ? String(hex.suffix(6)) : hex
        if hexString == "FFFFFF" || hexString == "white" {
            self.init(white: 1)
        }
        else if hexString == "000000" || hexString == "black" {
            self.init(white: 0)
        }
        else if let (r,g,b) = rbgValues(from: hexString) {
            self.init(red: r, green: g, blue: b)
        }
        else {
            return nil
        }
    }
}

fileprivate func rbgValues(from hexColor: String) -> (red: Double, green: Double, blue: Double)? {
    
    // If there aren't 6 characters in the hex color then return nil.
    guard hexColor.count == 6 else {
        debugPrint("WARNING! hexColor '\(hexColor)' does not have 6 characters.")
        return nil
    }
    
    let scanner = Scanner(string: hexColor)
    var hexNumber: UInt64 = 0
        
    // Scan the string into a hex.
    guard scanner.scanHexInt64(&hexNumber) else {
        debugPrint("WARNING! hexColor '\(hexColor)' failed to scan.")
        return nil
    }
    
    let r = Double((hexNumber & 0xff0000) >> 16) / 255
    let g = Double((hexNumber & 0x00ff00) >> 8) / 255
    let b = Double((hexNumber & 0x0000ff) >> 0) / 255
    
    return (r, g, b)
}

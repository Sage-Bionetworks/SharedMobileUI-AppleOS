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

extension Color {
    public static let sageBlack: Color = .init("sageBlack", bundle: Bundle.module)
    public static let sageWhite: Color = .init("sageWhite", bundle: Bundle.module)
    public static let screenBackground: Color = .init("screenBackground", bundle: Bundle.module)
    
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

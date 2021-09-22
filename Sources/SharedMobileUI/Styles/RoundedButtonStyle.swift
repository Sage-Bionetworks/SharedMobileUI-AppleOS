//
//  RoundedButtonStyle.swift
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

/// A button with rounded corners.
public struct RoundedButtonStyle : ButtonStyle {
    private let backgroundColor: Color
    private let horizontalPadding: CGFloat
    private let font: Font = DesignSystem.fontRules.buttonFont(at: 1, isSelected: false)
    
    /// Initializer.
    /// - Parameters:
    ///   - backgroundColor: The background color for the button.
    ///   - horizontalPadding: The horizontal padding.
    public init(_ backgroundColor: Color = .accentColor, horizontalPadding: CGFloat = 40) {
        self.backgroundColor = backgroundColor
        self.horizontalPadding = horizontalPadding
    }
    
    @ViewBuilder public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(font)
            .foregroundColor(.textForeground)
            .frame(minHeight: 48, idealHeight: 48)
            .frame(idealWidth: 209)
            .padding(.horizontal, horizontalPadding)
            .background(self.backgroundColor)
            .clipShape(Capsule())
            .shadow(color: Color.sageBlack.opacity(0.1), radius: 3, x: 1, y: 1)
    }
}

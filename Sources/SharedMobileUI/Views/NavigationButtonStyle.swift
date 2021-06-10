//
//  NavigationButtonStyle.swift
//  
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

public struct NavigationButtonStyle : ButtonStyle {
    private let foregroundColor: Color
    private let backgroundColor: Color
    private let style: Style
    
    public enum Style {
        case text, forward, backward
    }
    
    public init(_ style: Style = .text,
                foregroundColor: Color = Color.sageWhite,
                backgroundColor: Color = Color.sageBlack) {
        self.style = style
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    
    @ViewBuilder public func makeBody(configuration: Self.Configuration) -> some View {
        switch style {
        case .forward:
            Image.nextButton
        case .backward:
            Image.backButton
        default:
            configuration.label
                .font(Font.latoFont(20, relativeTo: .title2, weight: .bold))
                .foregroundColor(self.foregroundColor)
                .fixedSize(horizontal: false, vertical: true)
                .frame(height: 48)
                .padding(.horizontal, 40)
                .background(self.backgroundColor)
                .clipShape(Capsule())
        }
    }
}

struct NavigationButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button("Button", action: {})
                .buttonStyle(NavigationButtonStyle())
            Button("Button", action: {})
                .buttonStyle(NavigationButtonStyle(.forward))
        }
    }
}

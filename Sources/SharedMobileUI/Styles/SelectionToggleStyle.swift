//
//  SelectionToggleStyle.swift
//  
//
//  Copyright © 2022 Sage Bionetworks. All rights reserved.
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

public struct SelectionToggleStyle : ToggleStyle {
    #if os(iOS)
    @Environment(\.editMode) private var editMode
    #endif
    
    private let spacing: CGFloat
    private let selectedColor: Color
    private let isSingleSelect: Bool
    
    public init(spacing: CGFloat = 8, selectedColor: Color, isSingleSelect: Bool) {
        self.spacing = spacing
        self.selectedColor = selectedColor
        self.isSingleSelect = isSingleSelect
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        if isSingleSelect {
            buttonView(configuration)
                .buttonStyle(ToggleButtonStyle(isOn: configuration.isOn, selectedColor: selectedColor, clipShape: Capsule()))
        }
        else {
            buttonView(configuration)
                .buttonStyle(ToggleButtonStyle(isOn: configuration.isOn, selectedColor: selectedColor, clipShape: RoundedRectangle(cornerRadius: 5)))
        }
    }
    
    @ViewBuilder
    func buttonView(_ configuration: Configuration) -> some View {
        Button {
            #if os(iOS)
            if editMode?.wrappedValue.isEditing ?? false { return } // Exit early if editing
            #endif
            configuration.isOn.toggle()
        } label: {
            HStack(spacing: spacing) {
                toggleView(isOn: configuration.isOn)
                    .padding(.top, 17)
                    .padding(.bottom, 15)
                    .padding(.leading, 24)
                
                configuration.label
            }
        }
    }
    
    @ViewBuilder
    func toggleView(isOn: Bool) -> some View {
        if isSingleSelect {
            RadioButtonToggle(isOn: isOn)
        }
        else {
            CheckboxToggle(isOn: isOn)
        }
    }
}

fileprivate struct ToggleButtonStyle<S: Shape>: ButtonStyle {
    let isOn: Bool
    let selectedColor: Color
    let clipShape: S
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isOn == configuration.isPressed ? Color.sageWhite : selectedColor)
            .clipShape(clipShape)
            .shadow(color: .hex2A2A2A.opacity(0.1), radius: 3, x: 1, y: 2)
    }
}

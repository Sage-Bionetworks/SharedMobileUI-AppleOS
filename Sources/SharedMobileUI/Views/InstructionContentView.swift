//
//  InstructionContentView.swift
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

/// A view for displaying content that includes a title, detail, and image.
public struct InstructionContentView: View {
    
    /// The fontRatio determines how big the image is (or whether or not it is hidden) based on the accessiblity size.
    @ScaledMetric private var fontRatio: CGFloat = 1
    
    private let title: LocalizedStringKey
    private let detail: LocalizedStringKey
    private let imageName: String?
    private let bundle: Bundle?
    
    /// Initializer.
    /// - Parameters:
    ///   - title: The localized string key for the title of the view.
    ///   - detail: The localized string key for the detail of the view.
    ///   - imageName: The image name for the image to display in the view.
    ///   - bundle: The bundle for the localized strings and images.
    public init(title: LocalizedStringKey,
                detail: LocalizedStringKey,
                imageName: String? = nil,
                bundle: Bundle? = nil) {
        self.title = title
        self.detail = detail
        self.imageName = imageName
        self.bundle = bundle
    }
    
    public var body: some View {
        ScrollView {
            // Only show the image if the font size is not extra large.
            if let imageName = self.imageName,
               fontRatio < 1.5 {
                Image(imageName, bundle: bundle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 160.0 / fontRatio, alignment: .center)
                    .padding(.top, 10.0)
            }
            Text(title, bundle: bundle)
                .font(DesignSystem.fontRules.headerFont(at: 1))
                .padding(.top, 44.0)
                .padding(.bottom, 14.0)
                .padding(.horizontal, 60.0)
            Text(detail, bundle: bundle)
                .font(DesignSystem.fontRules.bodyFont(at: 1, isEmphasis: false))
                .padding(.horizontal, 56.0)
                .padding(.bottom, 14.0)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxHeight: .infinity)
        }
    }
}

extension Text {
    init(_ key: LocalizedStringKey, bundle: Bundle?) {
        self.init(key, tableName: nil, bundle: bundle, comment: nil)
    }
}

struct InstructionContentView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionContentView(title: "Hello, World!", detail: "This is some detail about this view")
    }
}

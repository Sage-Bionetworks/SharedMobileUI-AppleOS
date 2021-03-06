//
//  PagedNavigationBar.swift
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

/// A view for displaying forward/back navigation buttons and a progress indicator.
/// This view uses the ``PagedNavigationViewModel`` as its view model with that
/// object set up as an `@EnvironmentObject`.
public struct PagedNavigationBar : View {
    @EnvironmentObject private var viewModel: PagedNavigationViewModel
    let showsDots: Bool
    
    public init(showsDots: Bool = true) {
        self.showsDots = showsDots
    }
    
    public var body: some View {
        VStack(spacing: 0.0) {
            
            if self.showsDots, viewModel.pageCount > 0, !viewModel.progressHidden {
                PagingDotsView()
                    .padding(.vertical, (viewModel.forwardButtonText != nil) || viewModel.pageCount > 7 ?
                                8.0 : 0.0)
            }
                
            HStack {
                Button(action: viewModel.goBack, label: {
                    Text("Back", bundle: .module)
                })
                .buttonStyle(NavigationButtonStyle(.backward))
                .opacity(viewModel.backEnabled ? 1.0 : 0.0)
                
                Spacer()
                                
                Button(action: viewModel.goForward, label: {
                    if let buttonText = viewModel.forwardButtonText {
                        buttonText
                    }
                    else {
                        Text("Next", bundle: .module)
                    }
                })
                .buttonStyle(NavigationButtonStyle((viewModel.forwardButtonText == nil) ? .forwardArrow : .text))
                .buttonEnabled(viewModel.forwardEnabled)
            }
        }
    }
}

extension View {
    public func buttonEnabled(_ enabled: Bool) -> some View {
        modifier(ButtonEnabledModifier(enabled: enabled))
    }
}

public struct ButtonEnabledModifier : ViewModifier {
    var enabled: Bool
    public init(enabled: Bool) {
        self.enabled = enabled
    }
    
    public func body(content: Content) -> some View {
        content
            .opacity(enabled ? 1.0 : 0.5)
            .disabled(!enabled)
    }
}

struct PagingDotsView : View {
    @EnvironmentObject var viewModel: PagedNavigationViewModel
    let dotSize: CGFloat = 10
    var body: some View {
        HStack {
            ForEach(0..<viewModel.pageCount, id: \.self) { index in // 1
                      Circle()
                        .stroke(Color.sageBlack)
                        .background(Circle().foregroundColor(viewModel.currentIndex == index ?  .sageBlack : Color.clear))
                        .frame(width: dotSize, height: dotSize)
                        .id(index) // 4
                  }
        }
    }
}

struct PagedNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PagedNavigationBar()
                .environmentObject(PagedNavigationViewModel(pageCount: 5, currentIndex: 2))
            PagedNavigationBar()
                .environmentObject(PagedNavigationViewModel(pageCount: 5, currentIndex: 2))
                .preferredColorScheme(.dark)
            PagedNavigationBar()
                .environmentObject(PagedNavigationViewModel(pageCount: 5, currentIndex: 0))
            PagedNavigationBar()
                .environmentObject(PagedNavigationViewModel(pageCount: 5, currentIndex: 1, buttonText: Text("Next")))
            PagedNavigationBar()
                .environmentObject(PagedNavigationViewModel(pageCount: 5, currentIndex: 1, buttonText: Text("Next")))
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            PagedNavigationBar()
                .environmentObject(PagedNavigationViewModel(pageCount: 5, currentIndex: 1, buttonText: Text("Next")))
                .preferredColorScheme(.dark)
        }
    }
}


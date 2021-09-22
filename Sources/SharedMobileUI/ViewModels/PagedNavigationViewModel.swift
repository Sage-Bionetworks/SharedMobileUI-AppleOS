//
//  PagedNavigationViewModel.swift
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

/// A view model for a page-style navigation.
///
/// - SeeAlso: ``PagedNavigationBar``
public class PagedNavigationViewModel : ObservableObject {
    
    /// The direction of the navigator.
    public enum Direction {
        case forward, backward
    }
    
    /// The number of pages in the model.
    @Published public var pageCount: Int
    /// The current index (or page).
    @Published public var currentIndex: Int
    /// Is forward enabled?
    @Published public var forwardEnabled: Bool = true
    /// Is back enabled?
    @Published public var backEnabled: Bool = false
    /// The current direction of navigation.
    @Published public var currentDirection: Direction = .forward
    /// The text to display on the "forward" button.
    @Published public var forwardButtonText: Text? = nil
    /// Should the progress indicator be hidden?
    @Published public var progressHidden: Bool
    
    /// The action to call when the forward button is tapped. This will default to calling ``increment()``.
    lazy public var goForward: (() -> Void) = increment
    
    /// Increment the ``currentIndex`` and update the state of ``backEnabled`` and
    /// ``currentDirection``.
    public func increment() {
        guard self.currentIndex + 1 < self.pageCount else { return }
        self.currentIndex += 1
        self.backEnabled = self.currentIndex > 0
        self.currentDirection = .forward
    }
    
    /// The action to call when the back button is tapped. This will default to calling ``decrement()``.
    lazy public var goBack: (() -> Void) = decrement
    
    /// Decrement the ``currentIndex`` and update the state of ``backEnabled`` and
    /// ``currentDirection``.
    public func decrement() {
        guard self.currentIndex > 0 else { return }
        self.currentIndex -= 1
        self.backEnabled = self.currentIndex > 0
        self.currentDirection = .backward
    }
    
    public init(pageCount: Int = 0, currentIndex: Int = 0, buttonText: Text? = nil, progressHidden: Bool = false) {
        self.pageCount = pageCount
        self.progressHidden = progressHidden
        self.currentIndex = currentIndex
        self.backEnabled = currentIndex > 0
        self.forwardButtonText = buttonText
    }
}

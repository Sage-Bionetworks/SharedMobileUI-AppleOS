//
//  PagedNavigationViewModel.swift
//
//

import SwiftUI

/// A view model for a page-style navigation.
///
/// - SeeAlso: ``PagedNavigationBar``
public final class PagedNavigationViewModel : ObservableObject {
    
    /// The direction of the navigator.
    public enum Direction {
        case forward, backward
    }
    
    /// The number of pages in the model.
    @Published public var pageCount: Int {
        didSet {
            updateFraction()
        }
    }
    /// The current index (or page).
    @Published public var currentIndex: Int {
        didSet {
            updateFraction()
        }
    }
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
    /// progress as a fraction
    @Published public var fraction: Double = 0
    
    func updateFraction() {
        self.fraction = Double(currentIndex) / Double(pageCount > 0 ? pageCount : 1)
    }
    
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

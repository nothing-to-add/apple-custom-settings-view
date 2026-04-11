//
//  File name: SettingsAction.swift
//  Project name: apple-custom-settings-view
//  Workspace name: apple-custom-settings-view
//
//  Created by: nothing-to-add on 09/04/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

// MARK: - SettingsAction

/// Defines the action that is triggered when a ``SettingsItem`` is tapped.
///
/// Use `.url` to open a web page inside an in-app ``WebViewSheet``, or `.custom`
/// to run any arbitrary closure — for example, presenting a native sheet or
/// triggering in-app navigation.
///
/// ```swift
/// // Open a URL in the built-in web view
/// let privacyAction = SettingsAction.url(
///     URL(string: "https://example.com/privacy")!
/// )
///
/// // Run custom code
/// let rateAction = SettingsAction.custom {
///     SKStoreReviewController.requestReview()
/// }
/// ```
public enum SettingsAction: @unchecked Sendable {
    /// Opens the given `URL` in an in-app ``WebViewSheet`` when the row is tapped.
    case url(URL)

    /// Executes the provided closure when the row is tapped.
    ///
    /// - Parameter closure: A zero-argument, non-throwing closure invoked on the main thread.
    case custom(() -> Void)
}

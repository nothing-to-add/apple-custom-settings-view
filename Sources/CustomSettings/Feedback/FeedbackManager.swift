//
//  File name: FeedbackManager.swift
//  Project name: apple-custom-settings-view
//  Workspace name: apple-custom-settings-view
//
//  Created by: nothing-to-add on 19/04/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation
import SwiftUI
import MessageUI

// MARK: - FeedbackManager

/// Coordinates the in-app feedback flow driven by `MessageUI`.
///
/// `FeedbackManager` is a `@MainActor`-isolated singleton (`FeedbackManager.shared`).
/// It exposes two `@Published` properties that `SettingsView` observes to present
/// the mail-compose sheet and the fallback alert:
///
/// - `feedbackComposer` — set to a ``FeedbackComposer`` value to trigger the sheet;
///   cleared automatically when the sheet is dismissed.
/// - `showingMailUnavailableAlert` — set to `true` when `MFMailComposeViewController`
///   is unavailable (e.g. no Mail account configured on the device).
///
/// ## Usage
///
/// You do not need to create or hold a reference to `FeedbackManager` directly.
/// Add a ``SettingsItem/feedback(appName:email:)`` row to your `SettingsView` and the
/// manager is wired up automatically. If you need to trigger feedback from your own UI:
///
/// ```swift
/// FeedbackManager.shared.requestFeedback(appName: "MyApp", email: "hi@example.com")
/// ```
@MainActor
final class FeedbackManager: ObservableObject {
    /// Non-`nil` while the mail-compose sheet should be visible.
    ///
    /// Setting this to a ``FeedbackComposer`` value causes `SettingsView`'s
    /// `.sheet(item:)` modifier to present `FeedbackView`. Clearing it dismisses the sheet.
    @Published var feedbackComposer: FeedbackComposer? = nil

    /// `true` while the "Mail Not Available" alert should be visible.
    ///
    /// Becomes `true` when ``requestFeedback(appName:email:)`` is called but
    /// `MFMailComposeViewController.canSendMail()` returns `false`.
    @Published var showingMailUnavailableAlert = false

    /// The recipient address shown in the fallback alert message.
    var email = "support@yourapp.com"

    /// The host application's display name used in the mail template greeting.
    private var appName = "This App"

    /// The shared singleton instance.
    static let shared = FeedbackManager()
    
    private init() {}
    
    /// Attempts to present the native mail-compose UI for the given app and address.
    ///
    /// If `MFMailComposeViewController.canSendMail()` returns `true`, a
    /// ``FeedbackComposer`` is published and `SettingsView` shows `FeedbackView`.
    /// Otherwise `showingMailUnavailableAlert` is set to `true` so the host can
    /// prompt the user to configure Mail or copy the address manually.
    ///
    /// - Parameters:
    ///   - appName: The display name of the app, used in the mail subject and body.
    ///   - email: The recipient address for the feedback message.
    func requestFeedback(appName: String, email: String) {
        self.email = email
        if MFMailComposeViewController.canSendMail() {
            self.appName = appName
            feedbackComposer = FeedbackComposer(appName: appName, email: email)
        } else {
            showingMailUnavailableAlert = true
        }
    }
    
    /// Builds a pre-filled plain-text feedback message body.
    ///
    /// The body includes a friendly greeting, a placeholder section for the user's
    /// comments, and a technical footer with the app version, build number, iOS version,
    /// device model/name, and current date — useful for diagnosing bug reports.
    ///
    /// - Returns: A multi-line plain-text `String` ready to be passed to
    ///   `MFMailComposeViewController.setMessageBody(_:isHTML:)`.
    func createFeedbackTemplate() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
        let systemVersion = UIDevice.current.systemVersion
        let deviceModel = UIDevice.current.model
        let deviceName = UIDevice.current.name
        
        return """
        Hi \(appName) Team,

        I'd like to share some feedback about the app:
        
        [Please write your feedback, suggestions, or report any issues here]
        
        
        
        --- Technical Information ---
        App Version: \(appVersion) (\(buildNumber))
        iOS Version: \(systemVersion)
        Device Model: \(deviceModel)
        Device Name: \(deviceName)
        Date: \(Date().formatted())
        
        Thank you for creating this helpful app!
        """
    }
    
    /// Builds a pre-filled plain-text feedback message scoped to a specific feature.
    ///
    /// Delegates to ``createFeedbackTemplate()`` and replaces the generic placeholder
    /// with a feature-specific prompt.
    ///
    /// - Parameter feature: The name of the feature the user is commenting on
    ///   (e.g. `"notifications"`, `"dark mode"`).
    /// - Returns: A multi-line plain-text `String` ready to be passed to
    ///   `MFMailComposeViewController.setMessageBody(_:isHTML:)`.
    func createFeatureFeedbackTemplate(_ feature: String) -> String {
        let baseTemplate = createFeedbackTemplate()
        return baseTemplate.replacingOccurrences(
            of: "[Please write your feedback, suggestions, or report any issues here]",
            with: "[Please share your feedback about the \(feature) feature]"
        )
    }
}

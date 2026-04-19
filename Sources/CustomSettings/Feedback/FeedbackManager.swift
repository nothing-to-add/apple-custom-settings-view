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

@MainActor
final class FeedbackManager: ObservableObject {
    @Published var feedbackComposer: FeedbackComposer? = nil
    @Published var showingMailUnavailableAlert = false
    var email = "support@yourapp.com"
    private var appName = "This App"

    static let shared = FeedbackManager()
    
    private init() {}
    
    /// Check if mail is available and show appropriate UI
    func requestFeedback(appName: String, email: String) {
        self.email = email
        if MFMailComposeViewController.canSendMail() {
            self.appName = appName
            feedbackComposer = FeedbackComposer(appName: appName, email: email)
        } else {
            showingMailUnavailableAlert = true
        }
    }
    
    /// Create a pre-filled feedback template with device and app info
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
    
    /// Create feedback template for a specific feature
    func createFeatureFeedbackTemplate(_ feature: String) -> String {
        let baseTemplate = createFeedbackTemplate()
        return baseTemplate.replacingOccurrences(
            of: "[Please write your feedback, suggestions, or report any issues here]",
            with: "[Please share your feedback about the \(feature) feature]"
        )
    }
}

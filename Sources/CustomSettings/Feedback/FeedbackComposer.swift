//
//  File name: FeedbackComposer.swift
//  Project name: apple-custom-settings-view
//  Workspace name: apple-custom-settings-view
//
//  Created by: nothing-to-add on 19/04/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

/// A transient model that carries the data needed to present the mail-compose sheet.
///
/// `FeedbackComposer` is created by ``FeedbackManager/requestFeedback(appName:email:)``
/// and published as `feedbackManager.feedbackComposer`. SwiftUI's `.sheet(item:)` modifier
/// uses it as the `Identifiable` trigger — when the value is non-`nil` the sheet appears,
/// and clearing it dismisses the sheet.
struct FeedbackComposer: Identifiable {
    /// A stable unique identifier required by `Identifiable` / `ForEach`.
    let id = UUID()

    /// The display name of the host application, used as the greeting in the mail body.
    let appName: String

    /// The recipient e-mail address the feedback message is sent to.
    let email: String
}

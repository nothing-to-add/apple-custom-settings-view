//
//  File name: SettingsItem.swift
//  Project name: apple-custom-settings-view
//  Workspace name: apple-custom-settings-view
//
//  Created by: nothing-to-add on 09/04/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import Foundation

// MARK: - SettingsItem

/// A single row model used by ``SettingsView``.
///
/// Each item carries a display title, an SF Symbol icon name, and a
/// ``SettingsAction`` that fires when the row is tapped.
///
/// ```swift
/// let item = SettingsItem(
///     title: "Rate the App",
///     icon: "star",
///     action: .custom { print("rate tapped") }
/// )
/// ```
public struct SettingsItem: Identifiable {
    /// A stable unique identifier for this item, used by `ForEach`.
    public let id: UUID

    /// The text label displayed in the row.
    public let title: String

    /// The SF Symbol name used as the row icon.
    public let icon: String

    /// The action performed when this row is tapped.
    public let action: SettingsAction

    /// Creates a new `SettingsItem`.
    ///
    /// - Parameters:
    ///   - title: The text label displayed in the row.
    ///   - icon: An SF Symbol name for the row icon (e.g. `"lock"`, `"star"`).
    ///   - action: The ``SettingsAction`` triggered on tap.
    public init(title: String, icon: String, action: SettingsAction) {
        self.id = UUID()
        self.title = title
        self.icon = icon
        self.action = action
    }
}

// MARK: - Presets

public extension SettingsItem {
    /// A pre-built **Privacy Policy** row that opens the given URL.
    ///
    /// - Parameter url: The URL of your privacy policy page.
    static func privacyPolicy(url: URL) -> SettingsItem {
        SettingsItem(title: "Privacy Policy", icon: "lock", action: .url(url))
    }

    /// A pre-built **Terms of Service** row that opens the given URL.
    ///
    /// - Parameter url: The URL of your terms of service page.
    static func termsOfService(url: URL) -> SettingsItem {
        SettingsItem(title: "Terms of Service", icon: "doc.text", action: .url(url))
    }

    /// A pre-built **Help & Support** row that opens the given URL.
    ///
    /// - Parameter url: The URL of your help or support page.
    static func helpAndSupport(url: URL) -> SettingsItem {
        SettingsItem(title: "Help & Support", icon: "questionmark.circle", action: .url(url))
    }
}

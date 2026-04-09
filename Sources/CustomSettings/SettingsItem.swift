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

public struct SettingsItem: Identifiable {
    public let id: UUID
    public let title: String
    public let icon: String
    public let action: SettingsAction

    public init(title: String, icon: String, action: SettingsAction) {
        self.id = UUID()
        self.title = title
        self.icon = icon
        self.action = action
    }
}

// MARK: - Presets

public extension SettingsItem {
    static func privacyPolicy(url: URL) -> SettingsItem {
        SettingsItem(title: "Privacy Policy", icon: "lock", action: .url(url))
    }

    static func termsOfService(url: URL) -> SettingsItem {
        SettingsItem(title: "Terms of Service", icon: "doc.text", action: .url(url))
    }

    static func helpAndSupport(url: URL) -> SettingsItem {
        SettingsItem(title: "Help & Support", icon: "questionmark.circle", action: .url(url))
    }
}

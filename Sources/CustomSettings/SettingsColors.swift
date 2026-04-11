//
//  File name: SettingsColors.swift
//  Project name: apple-custom-settings-view
//  Workspace name: apple-custom-settings-view
//
//  Created by: nothing-to-add on 09/04/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

/// Holds the colour configuration used by ``SettingsView`` and its rows.
///
/// Pass a `SettingsColors` instance to ``SettingsView/init(colors:isEditing:)`` to
/// control the icon tint and row background across the entire settings screen.
///
/// ```swift
/// let colors = SettingsColors(
///     buttonImageForegroundColor: .accentColor,
///     buttonBackgroundColor: Color(.secondarySystemBackground)
/// )
/// ```
public class SettingsColors: ObservableObject {

    /// Creates a new colour configuration.
    ///
    /// - Parameters:
    ///   - buttonImageForegroundColor: The tint colour applied to the SF Symbol icon in each row.
    ///   - buttonBackgroundColor: The background colour of each row button.
    public init(buttonImageForegroundColor: Color, buttonBackgroundColor: Color) {
        self.buttonImageForegroundColor = buttonImageForegroundColor
        self.buttonBackgroundColor = buttonBackgroundColor
    }

    /// The tint colour applied to the SF Symbol icon in each row.
    public let buttonImageForegroundColor: Color

    /// The background colour of each row button.
    public let buttonBackgroundColor: Color
}

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

public enum SettingsAction: @unchecked Sendable {
    case url(URL)
    case custom(() -> Void)
}

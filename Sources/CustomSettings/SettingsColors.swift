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

public class SettingsColors: ObservableObject {
    
    init(buttonImageForegroundColor: Color, buttonBackgroundColor: Color) {
        self.buttonImageForegroundColor = buttonImageForegroundColor
        self.buttonBackgroundColor = buttonBackgroundColor
    }
    
    public let buttonImageForegroundColor: Color
    public let buttonBackgroundColor: Color
}

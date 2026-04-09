//
//  File name: SettingsRow.swift
//  Project name: apple-custom-settings-view
//  Workspace name: apple-custom-settings-view
//
//  Created by: nothing-to-add on 09/04/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

public struct SettingsRow: View {
    let item: SettingsItem
    let colors: SettingsColors
    let action: () -> Void

    public var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: item.icon)
                    .foregroundColor(colors.buttonImageForegroundColor)
                    .frame(width: 24)

                Text(item.title)
                    .font(.subheadline)
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(colors.buttonBackgroundColor)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SettingsRow(
        item: SettingsItem(title: "Notifications", icon: "bell", action: .custom { print("tapped") }),
        colors: SettingsColors(
            buttonImageForegroundColor: .blue,
            buttonBackgroundColor: Color(.secondarySystemBackground)
        ),
        action: { print("Notifications tapped") }
    )
    .padding()
}

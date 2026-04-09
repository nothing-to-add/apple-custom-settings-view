//
//  File name: SettingsView.swift
//  Project name: apple-custom-settings-view
//  Workspace name: apple-custom-settings-view
//
//  Created by: nothing-to-add on 09/04/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI

// MARK: - SettingsView

public struct SettingsView: View {
    private let colors: SettingsColors
    private let items: [SettingsItem]
    public var isEditing: Bool

    public init(colors: SettingsColors, isEditing: Bool = false) {
        self.colors = colors
        self.items = []
        self.isEditing = isEditing
    }

    private init(colors: SettingsColors, items: [SettingsItem], isEditing: Bool) {
        self.colors = colors
        self.items = items
        self.isEditing = isEditing
    }

    // MARK: - Builder

    public func add(_ item: SettingsItem) -> SettingsView {
        SettingsView(colors: colors, items: items + [item], isEditing: isEditing)
    }

    // MARK: - Body

    @State private var presentedURL: URL? = nil

    public var body: some View {
        VStack(spacing: 12) {
            ForEach(items) { item in
                SettingsRow(item: item, colors: colors) {
                    handleAction(item.action)
                }
                .disabled(isEditing)
            }
        }
        .sheet(item: $presentedURL) { url in
            WebViewSheet(url: url, title: urlTitle(for: url))
        }
    }

    // MARK: - Helpers

    private func handleAction(_ action: SettingsAction) {
        switch action {
        case .url(let url):
            presentedURL = url
        case .custom(let closure):
            closure()
        }
    }

    private func urlTitle(for url: URL) -> String {
        items.first { item in
            if case .url(let itemURL) = item.action { return itemURL == url }
            return false
        }?.title ?? ""
    }
}

// MARK: - URL + Identifiable

extension URL: @retroactive Identifiable {
    public var id: String { absoluteString }
}

// MARK: - Preview

#Preview {
    SettingsView(
        colors: SettingsColors(
            buttonImageForegroundColor: .blue,
            buttonBackgroundColor: Color(.secondarySystemBackground)
        )
    )
    .add(.privacyPolicy(url: URL(string: "https://nothing-to-add.github.io/app-legal-docs/pain-tracker/privacy-policy.html")!))
    .add(.termsOfService(url: URL(string: "https://nothing-to-add.github.io/app-legal-docs/pain-tracker/terms.html")!))
    .add(.helpAndSupport(url: URL(string: "https://nothing-to-add.github.io/app-legal-docs/pain-tracker/support.html")!))
    .padding()
}


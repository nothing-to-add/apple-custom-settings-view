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

/// A composable, Apple-style settings screen built with SwiftUI.
///
/// `SettingsView` renders a vertical list of tappable rows. Each row is
/// described by a ``SettingsItem`` and is added via the ``add(_:)`` builder
/// method, which makes the call site read like a declarative list.
///
/// ## Basic usage
///
/// ```swift
/// SettingsView(
///     colors: SettingsColors(
///         buttonImageForegroundColor: .accentColor,
///         buttonBackgroundColor: Color(.secondarySystemBackground)
///     )
/// )
/// .add(.privacyPolicy(url: URL(string: "https://example.com/privacy")!))
/// .add(.termsOfService(url: URL(string: "https://example.com/terms")!))
/// .add(.helpAndSupport(url: URL(string: "https://example.com/support")!))
/// .add(SettingsItem(title: "Rate the App", icon: "star", action: .custom {
///     // present StoreKit review prompt
/// }))
/// ```
///
/// ## Edit mode
///
/// Pass an `isEditing` binding to disable all rows while the parent view is
/// in an editing state:
///
/// ```swift
/// @State private var isEditing = false
///
/// SettingsView(colors: colors, isEditing: $isEditing)
///     .add(.privacyPolicy(url: privacyURL))
/// ```
public struct SettingsView: View {
    private let colors: SettingsColors
    private let items: [SettingsItem]
    @Binding public var isEditing: Bool

    /// Creates an empty `SettingsView` ready to have items added via ``add(_:)``.
    ///
    /// - Parameters:
    ///   - colors: The colour theme applied to every row.
    ///   - isEditing: A binding that disables all rows when `true`. Defaults to `false`.
    public init(colors: SettingsColors, isEditing: Binding<Bool> = .constant(false)) {
        self.colors = colors
        self.items = []
        self._isEditing = isEditing
    }

    private init(colors: SettingsColors, items: [SettingsItem], isEditing: Binding<Bool>) {
        self.colors = colors
        self.items = items
        self._isEditing = isEditing
    }

    // MARK: - Builder

    /// Returns a new `SettingsView` with the given item appended to the list.
    ///
    /// Chain multiple calls to build up the full settings screen:
    ///
    /// ```swift
    /// SettingsView(colors: colors)
    ///     .add(.privacyPolicy(url: privacyURL))
    ///     .add(.termsOfService(url: termsURL))
    /// ```
    ///
    /// - Parameter item: The ``SettingsItem`` to append.
    /// - Returns: A new `SettingsView` containing all previous items plus `item`.
    public func add(_ item: SettingsItem) -> SettingsView {
        SettingsView(colors: colors, items: items + [item], isEditing: $isEditing)
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


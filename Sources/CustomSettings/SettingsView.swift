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

public struct SettingsView: View {
    @StateObject private var colors: SettingsColors
    
    init(colors: SettingsColors, isEditing: Bool = false) {
        _colors = StateObject(wrappedValue: colors)
        self.isEditing = isEditing
    }
    
    // Sheet presentation state
    @State private var showingPrivacyPolicy = false
    @State private var showingTermsOfService = false
    @State private var showingSupport = false
    @State public var isEditing = false
    
    public var body: some View {
        VStack(spacing: 12) {
            SettingsRow(title: "Privacy Policy", icon: "lock", action: {
                showingPrivacyPolicy = true
            })
                .disabled(isEditing)
            
            SettingsRow(title: "Terms of Service", icon: "doc.text", action: {
                showingTermsOfService = true
            })
                .disabled(isEditing)
            
            // Feedback Button
//            FeedbackButton(
//                title: "Send Feedback",
//                icon: "envelope"
//            )
//            .disabled(isEditing)
            
            SettingsRow(title: "Help & Support", icon: "questionmark.circle", action: {
                showingSupport = true
            })
                .disabled(isEditing)
        }
        .sheet(isPresented: $showingPrivacyPolicy) {
            WebViewSheet(
                url: URL(string: "https://nothing-to-add.github.io/app-legal-docs/pain-tracker/privacy-policy.html")!,
                title: "Privacy Policy"
            )
        }
        .sheet(isPresented: $showingTermsOfService) {
            WebViewSheet(
                url: URL(string: "https://nothing-to-add.github.io/app-legal-docs/pain-tracker/terms.html")!,
                title: "Terms of Service"
            )
        }
        .sheet(isPresented: $showingSupport) {
            WebViewSheet(
                url: URL(string: "https://nothing-to-add.github.io/app-legal-docs/pain-tracker/support.html")!,
                title: "Help & Support"
            )
        }
    }
}

#Preview {
    SettingsView(
        colors: SettingsColors(
            buttonImageForegroundColor: .blue,
            buttonBackgroundColor: Color(.secondarySystemBackground)
        )
    )
}

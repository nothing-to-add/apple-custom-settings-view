//
//  File name: FeedbackView.swift
//  Project name: apple-custom-settings-view
//  Workspace name: apple-custom-settings-view
//
//  Created by: nothing-to-add on 19/04/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI
import MessageUI

// MARK: - FeedbackView

struct FeedbackView: UIViewControllerRepresentable {
    private let recipient: String
    private let subject: String
    private let messageBody: String
    
    @Environment(\.dismiss) private var dismiss
    
    init(recipient: String, appName: String, feedbackManager: FeedbackManager) {
        self.recipient = recipient
        self.subject = "\(appName) - Feedback"
        self.messageBody = feedbackManager.createFeedbackTemplate()
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let composer = MFMailComposeViewController()
        composer.setSubject(subject)
        composer.setToRecipients([recipient])
        composer.setMessageBody(messageBody, isHTML: false)
        composer.mailComposeDelegate = context.coordinator
        return composer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: FeedbackView
        
        init(parent: FeedbackView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}

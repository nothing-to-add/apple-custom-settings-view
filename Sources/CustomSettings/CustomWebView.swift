//
//  File name: CustomWebView.swift
//  Project name: apple-custom-settings-view
//  Workspace name: apple-custom-settings-view
//
//  Created by: nothing-to-add on 09/04/2026
//  Using Swift 6.0
//  Copyright (c) 2023 nothing-to-add
//

import SwiftUI
import WebKit

struct CustomWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(allowedURL: url)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let allowedURL: URL
        
        init(allowedURL: URL) {
            self.allowedURL = allowedURL
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let requestURL = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }
            
            // Only allow the initial URL to load
            if requestURL.absoluteString == allowedURL.absoluteString {
                decisionHandler(.allow)
            } else {
                // Block any other navigation
                decisionHandler(.cancel)
            }
        }
    }
}

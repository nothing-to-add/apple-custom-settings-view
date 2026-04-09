# GitHub Copilot Instructions

## Project Overview
This is **CustomSettings** — a Swift Package Manager library that provides a customisable Settings view for iOS apps. It presents a list of option buttons, allowing host apps to embed a flexible, Apple-style settings screen with configurable actions and labels.

## Stack
- **Language:** Swift 6.0, strict concurrency
- **UI:** SwiftUI only — no UIKit unless interacting with system APIs that require it
- **Distribution:** Swift Package Manager (SPM)
- **iOS Target:** iOS 17+

## Coding Conventions
- Every new file must start with the standard header comment block:
  ```swift
  //
  //  File name: <FileName>.swift
  //  Project name: apple-custom-settings-view
  //  Workspace name: apple-custom-settings-view
  //
  //  Created by: nothing-to-add on <DD/MM/YYYY>
  //  Using Swift 6.0
  //  Copyright (c) 2023 nothing-to-add
  //
  ```
- Every `class`, `struct`, and `enum` must live in its own dedicated file — no multiple type declarations per file
- Use `// MARK: -` sections to organise code within a file
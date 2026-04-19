# CustomSettings

A lightweight, Apple-style **Swift Package Manager** library that embeds a customisable Settings view — a list of tappable option buttons — into any SwiftUI app.

---

## Badges

![Swift](https://img.shields.io/badge/Swift-6.0-orange?logo=swift)
![SPM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen?logo=swift)
![iOS](https://img.shields.io/badge/iOS-17%2B-blue?logo=apple)
![macOS](https://img.shields.io/badge/macOS-13%2B-blue?logo=apple)
![watchOS](https://img.shields.io/badge/watchOS-9%2B-blue?logo=apple)
![visionOS](https://img.shields.io/badge/visionOS-1%2B-blue?logo=apple)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## Features

- 📋 **Built-in settings rows** — Privacy Policy, Terms of Service, Help & Support, and Feedback, each with a dedicated preset
- 📬 **In-app feedback** — `.feedback(appName:email:)` opens a pre-filled `MFMailComposeViewController`; falls back to a copy-address alert when Mail is unavailable
- 🎨 **Customisable colours** — configure icon foreground and button background colours via `SettingsColors`
- 🔒 **Edit-mode support** — pass `isEditing` to disable all rows while the host app is in an edit state
- 🌐 **Safe in-app web views** — `WebViewSheet` wraps `WKWebView` and blocks external navigation, keeping users inside the app
- 📱 **SwiftUI native** — built entirely with SwiftUI (WebKit and MessageUI used only where system APIs require it)
- 🔒 **Swift 6 strict concurrency** — safe to use in fully concurrent codebases
- 📦 **No external dependencies** — pure Swift, nothing to fetch

---

## Requirements

| Platform  | Minimum version |
|-----------|----------------|
| iOS       | 17.0+          |
| macOS     | 13.0+          |
| watchOS   | 9.0+           |
| visionOS  | 1.0+           |
| Swift     | 6.0+           |
| Xcode     | 16.0+          |

---

## Installation

### Swift Package Manager

1. In Xcode open **File › Add Package Dependencies…**
2. Paste the repository URL:
   ```
   https://github.com/nothing-to-add/apple-custom-settings-view
   ```
3. Select **Up to Next Major Version** starting from `1.0.0`
4. Add **CustomSettings** to your app target

#### `Package.swift` dependency

```swift
dependencies: [
    .package(
        url: "https://github.com/nothing-to-add/apple-custom-settings-view",
        from: "1.0.0"
    )
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "CustomSettings", package: "apple-custom-settings-view")
        ]
    )
]
```

---

## Quick Start

```swift
import SwiftUI
import CustomSettings

struct ContentView: View {
    var body: some View {
        SettingsView(
            colors: SettingsColors(
                buttonImageForegroundColor: .blue,
                buttonBackgroundColor: Color(.secondarySystemBackground)
            )
        )
        .add(.privacyPolicy(url: URL(string: "https://example.com/privacy")!))
        .add(.termsOfService(url: URL(string: "https://example.com/terms")!))
        .add(.helpAndSupport(url: URL(string: "https://example.com/support")!))
    }
}
```

---

## Adding Items

`SettingsView` uses a **builder pattern** — call `.add(_:)` to append rows. Each call returns a new `SettingsView` with the item appended, so you can chain as many calls as needed.

### Built-in preset items

Four preset `SettingsItem` factories are provided out of the box:

| Factory                                   | Default title      | SF Symbol             | Behaviour                              |
|-------------------------------------------|--------------------|-----------------------|----------------------------------------|
| `.privacyPolicy(url:)`                    | Privacy Policy     | `lock`                | Opens URL in in-app web sheet          |
| `.termsOfService(url:)`                   | Terms of Service   | `doc.text`            | Opens URL in in-app web sheet          |
| `.helpAndSupport(url:)`                   | Help & Support     | `questionmark.circle` | Opens URL in in-app web sheet          |
| `.feedback(appName:email:)`               | Feedback           | `envelope`            | Opens native mail-compose sheet        |

```swift
SettingsView(colors: colors)
    .add(.privacyPolicy(url: URL(string: "https://example.com/privacy")!))
    .add(.termsOfService(url: URL(string: "https://example.com/terms")!))
    .add(.helpAndSupport(url: URL(string: "https://example.com/support")!))
    .add(.feedback(appName: "MyApp", email: "feedback@example.com"))
```

### Custom items

Create a `SettingsItem` directly to add any row with a custom SF Symbol and action:

```swift
// Opens a URL in an in-app web sheet
let shareItem = SettingsItem(
    title: "Rate the App",
    icon: "star",
    action: .url(URL(string: "https://apps.apple.com/app/id000000000")!)
)

// Runs an arbitrary closure
let logoutItem = SettingsItem(
    title: "Log Out",
    icon: "rectangle.portrait.and.arrow.right",
    action: .custom { AuthService.shared.logOut() }
)

SettingsView(colors: colors)
    .add(shareItem)
    .add(logoutItem)
```

---

## Feedback

The `.feedback(appName:email:)` preset adds a **Feedback** row that opens the system mail-compose UI pre-filled with the recipient address, subject line, and a structured plain-text template that includes the user's device and app-version information.

```swift
SettingsView(colors: colors)
    .add(.feedback(appName: "MyApp", email: "feedback@example.com"))
```

### How it works

1. The user taps the **Feedback** row.
2. `FeedbackManager` checks `MFMailComposeViewController.canSendMail()`.
   - **Mail available** → the compose sheet appears pre-filled.
   - **Mail unavailable** → a "Mail Not Available" alert is shown with a **Copy Email** button so the user can paste the address into another client.

### Mail template

The auto-generated body contains:

- A personalised greeting using the app name
- A placeholder section for the user's message
- A technical footer with app version, build number, iOS version, device model/name, and current date

### Feature-scoped feedback

If you want to trigger feedback scoped to a specific feature from your own code:

```swift
let body = FeedbackManager.shared.createFeatureFeedbackTemplate("dark mode")
```

---

## Present

Present the settings screen modally from any view:

```swift
import SwiftUI
import CustomSettings

struct HomeView: View {
    @State private var showSettings = false

    var body: some View {
        Button("Open Settings") {
            showSettings = true
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(
                colors: SettingsColors(
                    buttonImageForegroundColor: .accentColor,
                    buttonBackgroundColor: Color(.secondarySystemBackground)
                )
            )
            .add(.privacyPolicy(url: URL(string: "https://example.com/privacy")!))
            .add(.termsOfService(url: URL(string: "https://example.com/terms")!))
            .add(.helpAndSupport(url: URL(string: "https://example.com/support")!))
        }
    }
}
```

---

## Edit mode

Pass a `Binding<Bool>` to `isEditing` to disable all rows while the host app is in an edit state. When the bound value changes, `SettingsView` reacts immediately:

```swift
struct ContentView: View {
    @State private var isEditing = false

    var body: some View {
        VStack {
            Toggle("Edit mode", isOn: $isEditing)

            SettingsView(colors: colors, isEditing: $isEditing)
                .add(.privacyPolicy(url: URL(string: "https://example.com/privacy")!))
        }
    }
}
```

---

## Configuration

### `SettingsColors`

Pass a `SettingsColors` instance to `SettingsView` to control the appearance of every row:

| Parameter                    | Type    | Description                                    |
|------------------------------|---------|------------------------------------------------|
| `buttonImageForegroundColor` | `Color` | Colour applied to each row's SF Symbol icon    |
| `buttonBackgroundColor`      | `Color` | Background colour of each row button           |

```swift
let colors = SettingsColors(
    buttonImageForegroundColor: .indigo,
    buttonBackgroundColor: Color(.secondarySystemBackground)
)
```

### `SettingsView`

| Parameter   | Type             | Default           | Description                                  |
|-------------|------------------|-------------------|----------------------------------------------|
| `colors`    | `SettingsColors` | —                 | Colour configuration for all rows            |
| `isEditing` | `Binding<Bool>`  | `.constant(false)`| When `true`, all rows are disabled           |

### `SettingsAction`

Each `SettingsItem` carries a `SettingsAction` that determines what happens when the row is tapped:

| Case                        | Behaviour                                                                                   |
|-----------------------------|---------------------------------------------------------------------------------------------|
| `.url(URL)`                 | Opens the URL in an in-app `WebViewSheet`                                                   |
| `.feedback(String, String)` | Opens `MFMailComposeViewController` pre-filled with a feedback template; shows a copy-address alert if Mail is unavailable |
| `.custom(() -> Void)`       | Calls the provided closure                                                                  |

### `SettingsRow`

Individual rows can be used standalone if you need to compose a custom layout:

```swift
SettingsRow(
    item: SettingsItem(
        title: "Notifications",
        icon: "bell",
        action: .custom { /* handle tap */ }
    ),
    colors: colors,
    action: { /* handle tap */ }
)
```

---

## License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for full details.

---

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit your changes following the project coding conventions
4. Open a Pull Request against `main`

Please ensure all new files include the standard header comment block and that each type lives in its own dedicated file.

---

## Support

If you encounter a bug or have a feature request, please [open an issue](https://github.com/nothing-to-add/apple-custom-settings-view/issues) on GitHub.

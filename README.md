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

- 📋 **Built-in settings rows** — Privacy Policy, Terms of Service, and Help & Support, each opening in an in-app web sheet
- 🎨 **Customisable colours** — configure icon foreground and button background colours via `SettingsColors`
- 🔒 **Edit-mode support** — pass `isEditing` to disable all rows while the host app is in an edit state
- 🌐 **Safe in-app web views** — `WebViewSheet` wraps `WKWebView` and blocks external navigation, keeping users inside the app
- 📱 **SwiftUI native** — built entirely with SwiftUI (WebKit used only where system APIs require it)
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
    }
}
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
        }
    }
}
```

---

## Configuration

### `SettingsColors`

Pass a `SettingsColors` instance to `SettingsView` to control the appearance of every row:

| Parameter                    | Type    | Description                              |
|------------------------------|---------|------------------------------------------|
| `buttonImageForegroundColor` | `Color` | Colour applied to each row's SF Symbol icon |
| `buttonBackgroundColor`      | `Color` | Background colour of each row button     |

```swift
let colors = SettingsColors(
    buttonImageForegroundColor: .indigo,
    buttonBackgroundColor: Color(.secondarySystemBackground)
)
```

### `SettingsView`

| Parameter   | Type            | Default | Description                                      |
|-------------|-----------------|---------|--------------------------------------------------|
| `colors`    | `SettingsColors` | —      | Colour configuration for all rows                |
| `isEditing` | `Bool`          | `false` | When `true`, all rows are disabled               |

The view includes three built-in rows that open an in-app web sheet:

| Row              | URL loaded                                      |
|------------------|-------------------------------------------------|
| Privacy Policy   | `…/pain-tracker/privacy-policy.html`            |
| Terms of Service | `…/pain-tracker/terms.html`                     |
| Help & Support   | `…/pain-tracker/support.html`                   |

### `SettingsRow`

Individual rows can also be used standalone:

```swift
SettingsRow(
    title: "Notifications",
    icon: "bell",
    action: { /* handle tap */ }
)
.environmentObject(colors)
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

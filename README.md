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

- 📋 **List of option buttons** — render any number of settings rows in a clean, Apple-style list
- ⚙️ **Fully configurable** — supply labels, icons, and action callbacks per row
- 🎨 **SwiftUI native** — built entirely with SwiftUI; zero UIKit dependencies
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
        SettingsView()
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
            SettingsView()
        }
    }
}
```

---

## Configuration

Each row in the settings list is represented by a `SettingsRow` that accepts a label, an optional SF Symbol icon, and an action closure:

```swift
import SwiftUI
import CustomSettings

struct ContentView: View {
    var body: some View {
        SettingsView(rows: [
            SettingsRow(title: "Notifications", icon: "bell") {
                // handle tap
            },
            SettingsRow(title: "Privacy", icon: "lock.shield") {
                // handle tap
            },
            SettingsRow(title: "About", icon: "info.circle") {
                // handle tap
            }
        ])
    }
}
```

> **Note:** The public API is under active development. Configuration options will expand in future releases.

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

# RemoSwift for Swift Package Manager

[![SPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/yi-jiang-applovin/Remo/blob/main/LICENSE)

This repo provides Swift Package Manager support for [Remo](https://github.com/yi-jiang-applovin/Remo) — a remote control bridge for iOS apps.

## Installing RemoSwift

### Swift Package Manager

1. In Xcode, select **File** → **Add Packages...**
2. Enter `https://github.com/yi-jiang-applovin/remo-spm.git`

Or add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/yi-jiang-applovin/remo-spm.git", from: "0.4.3")
```

Then add it to your target:

```swift
dependencies: [
    .product(name: "RemoSwift", package: "remo-spm")
]
```

### CocoaPods

```ruby
pod 'Remo', '~> 0.4.3'
```

## Why a separate repo?

The main [Remo](https://github.com/yi-jiang-applovin/Remo) repository contains the full Rust source code, build tools, CLI, and examples. Swift Package Manager downloads the entire git history when resolving packages, which would be unnecessarily large.

This `remo-spm` repo is tiny (< 100 KB). Instead of building from source, it points to a precompiled XCFramework from the [latest Remo release](https://github.com/yi-jiang-applovin/Remo/releases/latest).

## Quick Start

```swift
import RemoSwift

// In your app's setup (debug builds only):
Remo.register("myFeature.toggle") { params in
    let enabled = params["enabled"] as? Bool ?? false
    FeatureFlags.shared.myFeature = enabled
    return ["toggled": enabled]
}

Remo.start()
```

> **Note:** Remo is debug-only. In Release builds, all methods are no-ops — no TCP server is started, and no code from the Rust library is linked.

## Requirements

| Requirement | Version |
|-------------|---------|
| iOS | 15.0+ |
| Swift | 6.0+ |
| Xcode | 16+ |

## Privacy

Remo does not collect any data. The SDK opens a local TCP server for development debugging only and is compiled out of Release builds entirely.

## License

[MIT](https://github.com/yi-jiang-applovin/Remo/blob/main/LICENSE)

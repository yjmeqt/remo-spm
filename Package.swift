// swift-tools-version: 6.1

import PackageDescription

/// Precompiled XCFramework of the Remo SDK (Rust static library).
/// Built from https://github.com/yi-jiang-applovin/Remo
let remoXCFramework = Target.binaryTarget(
    name: "CRemo",
    url: "https://github.com/yi-jiang-applovin/Remo/releases/download/v0.3.0/RemoSDK.xcframework.zip",
    checksum: "7e93447937b19d7428dc2a8faf665edff09594d643a832f09812d413e92ed36a"
)

let package = Package(
    name: "RemoSwift",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "RemoSwift", targets: ["RemoSwift", "_RemoStub"]),
    ],
    targets: [
        remoXCFramework,

        .target(
            name: "RemoSwift",
            dependencies: ["CRemo"],
            path: "Sources/RemoSwift",
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedFramework("Security"),
            ]
        ),

        // Without at least one regular (non-binary) target, Xcode doesn't show the
        // package in "Frameworks, Libraries, and Embedded Content", which prevents
        // it from being embedded in the app product.
        // https://github.com/apple/swift-package-manager/issues/6069
        .target(name: "_RemoStub", path: "Sources/_RemoStub"),

        .testTarget(
            name: "RemoSwiftTests",
            dependencies: ["RemoSwift"],
            path: "Tests/RemoSwiftTests"
        ),
    ]
)

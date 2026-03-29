// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "RemoSwift",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "RemoSwift", targets: ["RemoSwift"]),
        .library(name: "RemoObjC", targets: ["RemoObjC"]),
    ],
    targets: [
        // The Rust static library packaged as an XCFramework.
        .binaryTarget(name: "CRemo", url: "https://github.com/yjmeqt/Remo/releases/download/v0.4.3/RemoSDK.xcframework.zip", checksum: "245273dcd4663dd1a9a5b7e03da1af4e280467992a8df56b53f0b7145376e6e3"),
        // CRemo is imported only in DEBUG builds (#if DEBUG in Remo.swift).
        // SPM still requires the binary for dependency resolution,
        // but unreferenced symbols are stripped by the linker in Release.
        .target(
            name: "RemoSwift",
            dependencies: ["CRemo"],
            path: "Sources/RemoSwift",
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedFramework("Security"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("VideoToolbox"),
                .linkedFramework("CoreFoundation"),
            ]
        ),
        .target(
            name: "RemoObjC",
            dependencies: ["CRemo"],
            path: "Sources/RemoObjC",
            publicHeadersPath: "include",
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedFramework("Security"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("VideoToolbox"),
                .linkedFramework("CoreFoundation"),
            ]
        ),
    ]
)

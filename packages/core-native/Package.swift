// swift-tools-version: 6.2

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("InferIsolatedConformances"),
]

let package = Package(
    name: "WebViewCore",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "WebViewCore", targets: ["WebViewCore"])
    ],
    targets: [
        .target(name: "WebViewCore", swiftSettings: swiftSettings),
        .testTarget(
            name: "WebViewCoreTests",
            dependencies: ["WebViewCore"],
            swiftSettings: swiftSettings
        ),
    ]
)

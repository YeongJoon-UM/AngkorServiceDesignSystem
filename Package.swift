// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AngkorServiceDesignSystem",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AngkorServiceDesignSystem",
            targets: ["AngkorServiceDesignSystem"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AngkorServiceDesignSystem",
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "AngkorServiceDesignSystemTests",
            dependencies: ["AngkorServiceDesignSystem"]),
    ]
)

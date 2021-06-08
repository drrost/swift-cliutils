// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CLIUtils",
    products: [
        .library(
            name: "CLIUtils",
            targets: ["CLIUtils"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CLIUtils",
            dependencies: []),
        .testTarget(
            name: "CLIUtilsTests",
            dependencies: ["CLIUtils"]),
    ]
)

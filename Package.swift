// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CLIUtils",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "CLIUtils",
            targets: ["CLIUtils"]),
        .library(
            name: "CLIUtilsLib",
            targets: ["CLIUtilsLib"]),
    ],
    dependencies: [
        .package(
            name: "RDFoundation",
            url: "git@github.com:drrost/swift-extensions-foundation.git",
            from: "1.0.0"),
        .package(
            name: "RDError",
            url: "git@github.com:drrost/swift-error.git",
            from: "1.0.0"),
        .package(
            name: "RDDI",
            url: "git@github.com:drrost/rddi.git",
            .exact("0.0.5")),
    ],
    targets: [
        .target(
            name: "CLIUtils",
            dependencies: ["CLIUtilsLib", "RDDI"]),
        .target(
            name: "CLIUtilsLib",
            dependencies: ["RDFoundation", "RDError", "RDDI"]),
        .testTarget(
            name: "CLIUtilsLibTests",
            dependencies: [
                "CLIUtilsLib",
                .product(name: "RDTest", package: "RDFoundation")
            ]),
    ]
)

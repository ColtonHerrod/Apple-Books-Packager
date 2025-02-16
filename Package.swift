// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cli",
    dependencies: [
      .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
      .package(url: "https://github.com/tadija/AEXML.git", branch: "master"),
      .package(url: "https://github.com/ColtonHerrod/EPUBKit.git", .upToNextMajor(from: "0.4.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "PackagerCli",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "AEXML", package: "AEXML"),
                .product(name: "EPUBKit", package: "EPUBKit")
            ],
            path: "Sources"),
        .testTarget(
            name: "PackagerTests",
            dependencies: ["PackagerCli"],
            resources: [.copy("Resources")]
        )    
    ]
)

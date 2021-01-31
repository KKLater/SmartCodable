// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmartCodable",
    products: [
        .library(name: "SmartCodable", targets: ["SmartCodable"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "SmartCodable", dependencies: []),
        .testTarget(name: "SmartCodableTests", dependencies: ["SmartCodable"]),
    ]
)

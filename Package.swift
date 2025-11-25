// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iOSCommonLibraries",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "iOSCommonLibraries",
            targets: ["iOS-Common-Libraries"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "iOS-Common-Libraries",
            dependencies: []),
        .testTarget(
            name: "iOS-Common-LibrariesTests",
            dependencies: ["iOS-Common-Libraries"]),
    ]
)

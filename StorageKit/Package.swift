// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StorageKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StorageKit",
            targets: ["StorageKit"]),
    ],
    dependencies: [
        .package(name: "KeychainSwift",
                 url: "https://github.com/evgenyneu/keychain-swift.git",
                 from: "24.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StorageKit",
            dependencies: ["KeychainSwift"]
        ),
        .testTarget(
            name: "StorageKitTests",
            dependencies: ["StorageKit"]
        ),
    ]
)

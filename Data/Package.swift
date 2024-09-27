// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "DataConfigurations",
            targets: ["DataConfigurations"]),
        .library(
            name: "CharactersData",
            targets: ["CharactersData"]),
    ],
    dependencies: [
        .package(name: "Networking", path: "../Networking"),
        .package(name: "Domain", path: "../Domain"),
    ],
    targets: [
        .target(
            name: "DataConfigurations",
            dependencies: ["Networking"]
        ),
        .target(
            name: "CharactersData",
            dependencies: [
                .target(name: "DataConfigurations"),
                .product(name: "CoreDomain", package: "Domain"),
                .product(name: "CharactersDomain", package: "Domain"),
                .product(name: "Networking", package: "Networking")
            ]
        ),
        .testTarget(
            name: "DataConfigurationsTests",
            dependencies: ["DataConfigurations"]),
        .testTarget(
            name: "CharactersDataTests",
            dependencies: ["CharactersData"])
    ]
)

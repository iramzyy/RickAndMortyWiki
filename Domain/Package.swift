// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "CoreDomain",
            targets: ["CoreDomain"]),
        .library(
            name: "CharactersDomain",
            targets: ["CharactersDomain"])
    ],
    targets: [
        .target(
            name: "CoreDomain"
        ),
        .target(
            name: "CharactersDomain",
            dependencies: [
                .target(name: "CoreDomain")
            ]
        ),
        .testTarget(
            name: "CharactersDomainTests",
            dependencies: ["CharactersDomain"]
        )

    ]
)

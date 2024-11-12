// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Rea",
    platforms: [.macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Rea",
            targets: ["Rea"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Rea",
            dependencies: [.target(
                name: "Renderer"
            )]
        ),
        .target(name: "Renderer")
    ]
)

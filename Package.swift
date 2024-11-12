// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Rea",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "Rea",
            targets: ["Rea"]
        ),
    ],
    targets: [
        .target(
            name: "Rea",
            dependencies: [.target(name: "Renderer")]
        ),
        // MARK: - Renderer
        .target(name: "Renderer"),
        
        // MARK: - Demo App
        .executableTarget(
            name: "Demo",
            dependencies: [.target(name: "Rea")]
        )
    ]
)

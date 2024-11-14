// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Rea",
    platforms: [.macOS(.v14)],
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
        .target(
            name: "Renderer",
            dependencies: [.target(name: "Shared")],
            resources: [.process("Shaders")]
        ),

        // MARK: - Shared types
        .target(name: "Shared"),
        
        // MARK: - Demo App
        .executableTarget(
            name: "Demo",
            dependencies: [.target(name: "Rea")]
        )
    ]
)

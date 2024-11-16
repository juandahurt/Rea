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
            dependencies: ["Shared"],
            resources: [.process("Renderer/Shaders")]
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

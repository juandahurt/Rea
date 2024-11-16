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
            dependencies: ["ReaCore"],
            resources: [.process("Renderer/Shaders")]
        ),

        // MARK: - Core types
        .target(name: "ReaCore"),
        
        // MARK: - Demo App
        .executableTarget(
            name: "Demo",
            dependencies: [.target(name: "Rea")]
        )
    ]
)

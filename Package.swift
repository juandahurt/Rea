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
            dependencies: ["ReaCore", "ReaMath"],
            resources: [.process("Renderer/Shaders")]
        ),

        .target(name: "ReaMath", dependencies: ["ReaCore"]),
        
        // MARK: - Core types
        .target(name: "ReaCore")
    ]
)

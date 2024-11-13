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
            resources: [.process("Shaders")]
        ),
        
        // MARK: - Demo App
        .executableTarget(
            name: "Demo",
            dependencies: [.target(name: "Rea")]
        )
    ]
)

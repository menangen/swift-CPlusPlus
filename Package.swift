// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "v8app",
    dependencies: [],
    targets: [
        .target(
            name: "game",
            dependencies: [],
            path: "Sources/game"),
        .target(
            name: "js",
            dependencies: ["game"],
            path: "Sources/js"),
        .target(
            name: "server",
            dependencies: ["js"])
    ]
)

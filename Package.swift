// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "v8",
    dependencies: [],
    targets: [
        .target(
            name: "js",
            dependencies: [],
            path: "Sources/js"),
        .target(
            name: "v8",
            dependencies: ["js"])
    ]
)

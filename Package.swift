// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "swift-c++",
    dependencies: [],
    targets: [
        .target(
            name: "js",
            dependencies: [],
            path: "Sources/js"),
        .target(
            name: "swift",
            dependencies: ["js"])
    ]
)

// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "DeepGagan",
    products: [
        .executable(name: "DeepGagan", targets: ["DeepGagan"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "DeepGagan",
            dependencies: ["Publish"]
        )
    ]
)
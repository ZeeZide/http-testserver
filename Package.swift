// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "http-testserver",
    dependencies: [
        .package(url: "https://github.com/ZeeZide/http.git",
                 .branch("feature/gcd-async-server"))
    ],
    targets: [
        .target(
            name: "http-testserver",
            dependencies: [ "HTTP" ]),
    ]
)

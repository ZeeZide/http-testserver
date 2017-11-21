// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
  let branch = "feature/gcd-async-server-swift3compat"
#else
  let branch = "feature/gcd-async-server"
#endif

let package = Package(
    name: "http-testserver",
    dependencies: [
        .package(url: "https://github.com/ZeeZide/http.git",
                 .branch(branch))
    ],
    targets: [
        .target(
            name: "http-testserver",
            dependencies: [ "HTTP" ]),
    ]
)

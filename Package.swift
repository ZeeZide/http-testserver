
import PackageDescription

let package = Package(
    name: "http-testserver",
    dependencies: [
        .package(url: "https://github.com/ZeeZide/http.git",
                 majorVersion: 0, minor: 2)
    ]
)

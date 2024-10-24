// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "devicecheckkit",
  platforms: [
    .macOS(.v13),
    .macCatalyst(.v16),
    .iOS(.v16),
    .tvOS(.v16),
    .watchOS(.v9),
    .visionOS(.v1),
  ],
  products: [
    .library(
      name: "DeviceCheckKit",
      targets: ["DeviceCheckKit"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/vapor/jwt-kit", from: "5.0.1"),
    .package(url: "https://github.com/apple/swift-http-types", from: "1.3.0"),
    .package(url: "https://github.com/zunda-pixel/http-client", from: "0.3.0"),
  ],
  targets: [
    .target(
      name: "DeviceCheckKit",
      dependencies: [
        .product(name: "JWTKit", package: "jwt-kit"),
        .product(name: "HTTPTypes", package: "swift-http-types"),
        .product(name: "HTTPClient", package: "http-client"),
      ]
    ),
  ]
)

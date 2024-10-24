## DeviceCheckKit(Server Side)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fzunda-pixel%2Fdevicecheckkit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/zunda-pixel/devicecheckkit)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fzunda-pixel%2Fdevicecheckkit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/zunda-pixel/devicecheckkit)

```swift
let deviceCheck = DeviceCheck(
  httpClient: .urlSession(.shared),
  environmet: .development,
  teamId: "PSDFSDIZ2",
  p8KeyId: "C6KIJDSFU3U",
  p8PrivateKey: Data("""
-----BEGIN PRIVATE KEY-----
MIGTAgEA1iWERDFijafjkwdwIBAQQgoM7Jt05epfNvxVEL
idr/RupT
-----END PRIVATE KEY-----
""".utf8)
)

func registDeviceToken(deviceToken: Data) {
  try await deviceCheck.updateTwoBits(deviceToken: deviceToken)
}
````

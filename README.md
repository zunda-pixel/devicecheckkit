## DeviceCheckKit(Server Side)

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

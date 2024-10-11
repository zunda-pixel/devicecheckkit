import Foundation
import HTTPTypes
import JWTKit

extension DeviceCheck {
  internal func execute(
    endpoint: URL,
    deviceToken: Data,
    timestamp: Date,
    transactionId: String = UUID().uuidString,
    bit0: Bool?,
    bit1: Bool?
  ) async throws -> (Data, HTTPResponse) {
    let jwt = JWTKeyCollection()
    let now = Date.now
    let payload = Payload(
      issuer: IssuerClaim(value: self.teamId),
      issuedAt: IssuedAtClaim(value: now),
      expiredAt: ExpirationClaim(value: now.addingTimeInterval(60 * 60))
    )
    let p8PrivateKey = try ES256PrivateKey(pem: p8PrivateKey)

    await jwt.add(ecdsa: p8PrivateKey)
    let authorizationToken = try await jwt.sign(
      payload,
      kid: JWKIdentifier(string: self.p8KeyId)
    )

    let body = Body(
      deviceToken: deviceToken.base64EncodedString(),
      transactionId: transactionId,
      timestamp: Int(timestamp.timeIntervalSince1970.rounded()) * 1000,
      bit0: bit0,
      bit1: bit1
    )
    let bodyData = try JSONEncoder().encode(body)
    let request = HTTPRequest(
      method: .post,
      url: endpoint,
      headerFields: [
        .contentType: "application/json",
        .authorization: "Bearer \(authorizationToken)",
      ]
    )
    return try await self.httpClient.execute(
      for: request,
      from: bodyData
    )
  }
}

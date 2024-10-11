import JWTKit

struct Payload: JWTPayload {
  var issuer: IssuerClaim
  var issuedAt: IssuedAtClaim
  var expiredAt: ExpirationClaim
  private enum CodingKeys: String, CodingKey {
    case issuer = "iss"
    case issuedAt = "iat"
    case expiredAt = "exp"
  }

  func verify(using algorithm: some JWTKit.JWTAlgorithm) async throws {
    try self.expiredAt.verifyNotExpired()
  }
}

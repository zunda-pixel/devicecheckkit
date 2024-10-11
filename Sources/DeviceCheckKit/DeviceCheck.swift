import Foundation
import HTTPClient
import HTTPTypes
import JWTKit

public struct DeviceCheck<HTTPClient: HTTPClientProtocol & Sendable>: Sendable {
  public var httpClient: HTTPClient
  public var environmet: Environment
  public var teamId: String
  public var p8KeyId: String
  public var p8PrivateKey: Data

  public init(
    httpClient: HTTPClient,
    environmet: Environment,
    teamId: String,
    p8KeyId: String,
    p8PrivateKey: Data
  ) {
    self.httpClient = httpClient
    self.environmet = environmet
    self.teamId = teamId
    self.p8KeyId = p8KeyId
    self.p8PrivateKey = p8PrivateKey
  }

  var baseUrl: URL {
    switch environmet {
    case .development:
      URL(string: "https://api.development.devicecheck.apple.com")!
    case .production:
      URL(string: "https://api.devicecheck.apple.com")!
    }
  }

  public func twoBits(deviceToken: Data) async throws -> TwoBits {
    let endpoint = baseUrl.appending(path: "v1/query_two_bits")
    let (data, response) = try await execute(
      endpoint: endpoint,
      deviceToken: deviceToken,
      timestamp: .now,
      bit0: nil,
      bit1: nil
    )
    if response.status == .ok {
      let twoBits = try JSONDecoder().decode(TwoBits.self, from: data)
      return twoBits
    } else {
      let description = String(decoding: data, as: UTF8.self)
      throw DeviceCheckError(
        status: response.status,
        description: description
      )
    }
  }

  public func updateTwoBits(deviceToken: Data) async throws {
    let endpoint = baseUrl.appending(path: "v1/update_two_bits")
    let (data, response) = try await execute(
      endpoint: endpoint,
      deviceToken: deviceToken,
      timestamp: .now,
      bit0: true,
      bit1: false
    )

    if response.status != .ok {
      let description = String(decoding: data, as: UTF8.self)
      throw DeviceCheckError(
        status: response.status,
        description: description
      )
    }
  }

  public func validateDeviceToken(deviceToken: Data) async throws {
    let endpoint = baseUrl.appending(path: "v1/validate_device_token")
    let (data, response) = try await execute(
      endpoint: endpoint,
      deviceToken: deviceToken,
      timestamp: .now,
      bit0: true,
      bit1: false
    )

    if response.status != .ok {
      let description = String(decoding: data, as: UTF8.self)
      throw DeviceCheckError(
        status: response.status,
        description: description
      )
    }
  }
}

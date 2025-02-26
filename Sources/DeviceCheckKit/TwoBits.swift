import Foundation

public struct TwoBits: Decodable, Sendable, Hashable {
  public var bit0: Bool
  public var bit1: Bool
  public var lastUpdateTime: Date

  private enum CodingKeys: String, CodingKey {
    case bit0
    case bit1
    case lastUpdateTime = "last_update_time"
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.bit0 = try container.decode(Bool.self, forKey: .bit0)
    self.bit1 = try container.decode(Bool.self, forKey: .bit1)
    let lastUpdateTime = try container.decode(String.self, forKey: .lastUpdateTime)
    self.lastUpdateTime = try Date(lastUpdateTime, strategy: .iso8601.year().month())
  }
}

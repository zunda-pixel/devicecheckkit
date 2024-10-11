struct Body: Codable {
  var deviceToken: String
  var transactionId: String
  var timestamp: Int
  var bit0: Bool?
  var bit1: Bool?

  private enum CodingKeys: String, CodingKey {
    case deviceToken = "device_token"
    case transactionId = "transaction_id"
    case timestamp
    case bit0
    case bit1
  }
}

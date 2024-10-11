import Foundation
import HTTPTypes

public struct DeviceCheckError: Error {
  public var status: HTTPResponse.Status
  public var description: String
}

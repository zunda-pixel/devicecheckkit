//
//  ContentView.swift
//  ExampleDeviceCheckApp
//
//  Created by zunda on 2024/10/11.
//

import SwiftUI
import DeviceCheck
import DeviceCheckKit


let deviceCheck = DeviceCheck(
  httpClient: .urlSession(.shared),
  environmet: .development,
  teamId: "PU5HXZ4FZ2",
  p8KeyId: "C6K99BZ93U",
  p8PrivateKey: Data("""
-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgoM7Jt05epfNvxVEL
8iOSEZusadXFlw8PMdzHvkGWnrOgCgYIKoZIzj0DAQehRANCAAR3poUdg7RH2yCg
UN+nF3/VSf6SNGj6CUBezvOV6lpsTn47/Qw1g3DB4IQMcLL2m4TEyzo/XlACRp0J
idr/RupT
-----END PRIVATE KEY-----
""".utf8)
)

struct ContentView: View {
  @State var error: Error?
  @State var twoBits: TwoBits?
  
  func registerDeviceToken() async throws {
    let deviceToken = try await DCDevice.current.generateToken()
    try await deviceCheck.updateTwoBits(deviceToken: deviceToken)
    print("Success Register DeviceToken")
  }
  
  func fetchTwoBits() async throws {
    let deviceToken = try await DCDevice.current.generateToken()
    self.twoBits = try await deviceCheck.twoBits(deviceToken: deviceToken)
    print("Success Fetch Two Bits")
  }
  
  func validateDeviceToken() async throws {
    let deviceToken = try await DCDevice.current.generateToken()
    try await deviceCheck.validateDeviceToken(deviceToken: deviceToken)
    print("Success Validate DeviceToken")
  }
  
  var body: some View {
    List {
      Button("Register") {
        Task {
          do {
            try await registerDeviceToken()
          } catch {
            print(error)
            self.error = error
          }
        }
      }
      
      Button("Fetch Two Bits") {
        Task {
          do {
            try await fetchTwoBits()
          } catch {
            print(error)
            self.error = error
          }
        }
      }
      
      Button("Validate Device Token") {
        Task {
          do {
            try await validateDeviceToken()
          } catch {
            print(error)
            self.error = error
          }
        }
      }
      
      if let twoBits {
        Text(twoBits.lastUpdateTime.description)
        Text(twoBits.bit0.description)
        Text(twoBits.bit1.description)
      }
      
      if let error {
        Text(error.localizedDescription)
      }
    }
  }
}

#Preview {
  ContentView()
}

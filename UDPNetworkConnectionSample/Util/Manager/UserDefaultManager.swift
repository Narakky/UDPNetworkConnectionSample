//
//  UserDefaultManager.swift
//  UDPNetworkConnectionSample
//
//  Created by Naraki on 8/9/19.
//  Copyright © 2019 i-enter. All rights reserved.
//

import Foundation

struct UserDefaultManager {
  enum Key: String {
    case ipAddress
    case port
  }

  // MARK: - Constants

  static let shared = UserDefaultManager()

  // MARK: - Initializer

  private init() {}

  func get(key: Key) -> Any? {
    return UserDefaults.standard.object(forKey: key.rawValue)
  }

  func set(key: Key, value: Any) {
    return UserDefaults.standard.set(value, forKey: key.rawValue)
  }
}

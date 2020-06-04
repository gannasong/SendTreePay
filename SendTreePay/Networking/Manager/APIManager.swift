//
//  APIManager.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/5/29.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation
import Moya

final public class APIManager: NSObject {

  internal enum Keys: String {
    case features
    case demo
  }

  public static let shared = APIManager()
  public let provider = MoyaProvider<APIType>()
}

//
//  APIType.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/5/29.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation
import Moya

public enum APIType {
  case fetchDemoData
  case fetchMaskData
}

extension APIType: TargetType {

  public var baseURL: URL {
    switch self {
      case .fetchDemoData: return URL(string: "https://demo_data/")!
      default: return URL(string: "https://raw.githubusercontent.com/")!
    }
  }

  public var path: String {
    switch self {
      case .fetchDemoData: return "demo_path"
      case .fetchMaskData: return "kiang/pharmacies/master/json/points.json"
    }
  }

  public var method: Moya.Method {
    switch self {
      case .fetchDemoData:
        return .post
      default:
        return .get
    }
  }

  public var sampleData: Data {
    return Data()
  }

  var parameters: [String: Any]? {
    let parameters: [String: Any] = [:]
    return parameters
  }

  public var task: Task {
    guard let parameters = parameters else { return .requestPlain }

    switch self {
      case .fetchDemoData:
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
      default:
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
  }

  public var headers: [String : String]? {
    return [
      "Content-Type": "application/json",
    ]
  }
}

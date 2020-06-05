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
  case fetchMaskData
}

extension APIType: TargetType {

  public var baseURL: URL {
    switch self {
      case .fetchMaskData:
        return URL(string: "https://raw.githubusercontent.com/")!
    }
  }

  public var path: String {
    switch self {
      case .fetchMaskData:
        return "kiang/pharmacies/master/json/points.json"
    }
  }

  public var method: Moya.Method {
    switch self {
      case .fetchMaskData:
        return .get
    }
  }

  public var sampleData: Data {
    return stubedResponse("FeatureData")
  }

  var parameters: [String: Any]? {
    let parameters: [String: Any] = [:]
    return parameters
  }

  public var task: Task {
    guard let parameters = parameters else { return .requestPlain }

    switch self {
      case .fetchMaskData:
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
  }

  public var headers: [String : String]? {
    return [
      "Content-Type": "application/json",
    ]
  }

  // MARK: - Private Methods

  private func stubedResponse(_ filename: String) -> Data! {
    let bundlePath = Bundle.main.path(forResource: "Stubs", ofType: "bundle")
    let bundle = Bundle(path: bundlePath!)
    let path = bundle?.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
  }
}

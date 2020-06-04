//
//  APIManager+Mask.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/5/29.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension APIManager {
  func fetchMaskData() -> Observable<[County]> {
    return provider.rx.request(.fetchMaskData)
      .asObservable()
      .filterSuccessfulStatusCodes()
      .map([Pharmacy].self, atKeyPath: Keys.features.rawValue)
      .separateToCounty()
  }
}

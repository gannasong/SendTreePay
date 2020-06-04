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
//  public func fetchMaskData() {
//    _ = provider.rx.request(.fetchMaskData)
//      .asObservable()
//      .filterSuccessfulStatusCodes()
//      .map([Pharmacy].self, atKeyPath: Keys.features.rawValue)
//      .subscribe(onNext: { (pharmacies) in
//        print(">>>>> count: ", pharmacies.count)
//        pharmacies.forEach { (pharmacy) in
//          print(">>>>> name: ", pharmacy.name)
//        }
//      }, onError: { (error) in
//        print(">>>>> error: ", error.localizedDescription)
//      })
//  }

  func fetchMaskData() -> Observable<[Pharmacy]> {
    return provider.rx.request(.fetchMaskData)
      .asObservable()
      .filterSuccessfulStatusCodes()
      .map([Pharmacy].self, atKeyPath: Keys.features.rawValue)
  }
}

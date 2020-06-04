//
//  RxSwift+Operators.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/6/4.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import RxSwift
import RxCocoa

extension Observable {
  func separateToCounty() -> Observable<[County]> {
    return map { pharmacies in
      guard let pharmacyArray = pharmacies as? [Pharmacy] else { return [] }
      return Dictionary(grouping: pharmacyArray) { $0.county ?? "" }
        .map { (key, value) in
          return County(name: key.isEmpty ? "未分區" : key,
                        adultMaskCount: value.reduce(0, { $0 + ($1.maskAdult ?? 0) }),
                        childMaskCount: value.reduce(0, { $0 + ($1.maskChild ?? 0) }),
                        pharmacies: value)
      }
    }
  }
}

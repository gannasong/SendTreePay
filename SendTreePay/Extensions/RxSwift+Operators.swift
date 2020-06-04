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
      print(">>>>> pharmacies count: ", pharmacyArray.count)
      var countyArray = [County]()
      _ = Dictionary(grouping: pharmacyArray) { $0.county }
        .compactMap { (key, value) in
          guard let key = key else { return }
          print(">>>>>> key: ", key)
          print(">>>>>value: ", value.count)
          let countyName = key.isEmpty ? "未分區" : key
          let adultMaskCount = value.reduce(0) { $0 + ($1.maskAdult ?? 0) }
          let childMaskCount = value.reduce(0) { $0 + ($1.maskChild ?? 0) }
          countyArray.append(County(name: countyName, adultMaskCount: adultMaskCount, childMaskCount: childMaskCount, pharmacies: value))
      }

      return countyArray
    }
  }
}

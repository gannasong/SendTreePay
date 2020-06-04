//
//  CountySection.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/6/4.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import RxDataSources

struct CountySection {
  var header: String = ""
  var items: [County]
}

extension CountySection: SectionModelType {
  init(original: CountySection, items: [County]) {
    self = original
    self.items = items
  }
}

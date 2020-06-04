//
//  ViewModelType.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/6/3.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

protocol ViewModelType {
  associatedtype Input
  associatedtype Output

  func transform(input: Input) -> Output
}


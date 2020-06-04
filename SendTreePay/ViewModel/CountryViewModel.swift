//
//  CountryViewModel.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/6/3.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa

final class CountryViewModel: ViewModelType {

  private let disposeBag = DisposeBag()

  // MARK: - ViewModelType

  struct Input {
    let fetchContentTrigger: PublishSubject<Void>
  }

  struct Output {
    let items: BehaviorRelay<[Pharmacy]>
    let loadError: PublishSubject<Error>
  }

  func transform(input: Input) -> Output {
    let item = BehaviorRelay<[Pharmacy]>(value: [])
    let loadError = PublishSubject<Error>()

    input.fetchContentTrigger
      .flatMapLatest { _ -> Observable<[Pharmacy]> in
        return APIManager.shared.fetchMaskData()
    }
    .compactMap { $0 }
    .subscribe(onNext: { (items) in
      item.accept(items)
    }, onError: { (error) in
      loadError.onNext(error)
    }).disposed(by: disposeBag)

    return Output(items: item, loadError: loadError)
  }
}

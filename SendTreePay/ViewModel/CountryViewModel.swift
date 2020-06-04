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
//    let fetchContentTrigger: PublishSubject<Void>
    let fetchContentTrigger: Observable<Void>
  }

  struct Output {
    let items: BehaviorRelay<[County]>
    let isLoading: BehaviorRelay<Bool>
    let loadError: PublishSubject<Error>
  }

  func transform(input: Input) -> Output {
    let item = BehaviorRelay<[County]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: true)
    let loadError = PublishSubject<Error>()

    input.fetchContentTrigger
      .flatMapLatest { _ -> Observable<[County]> in
        isLoading.accept(true)
        return APIManager.shared.fetchMaskData()
      }
    .compactMap { $0 }
    .subscribe(onNext: { (items) in
      item.accept(items)
      isLoading.accept(false)
    }, onError: { (error) in
      loadError.onNext(error)
    }).disposed(by: disposeBag)

    return Output(items: item, isLoading: isLoading, loadError: loadError)
  }
}

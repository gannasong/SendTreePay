//
//  ViewController.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/5/29.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {

  private var viewModel: CountryViewModel?
  private let fetchContentTrigger = PublishSubject<Void>()
  private let disposeBag = DisposeBag()

  lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .red
    return activityIndicator
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
//    bindViewModel()

    APIManager.shared.fetchMaskData()
      .separateToCounty()
      .asObservable()
      .subscribe { (items) in
        guard let items = items.element else { return }
        items.forEach { (county) in
          print(">>>>>>> County Name: \(county.name), adultMaskCount: \(county.adultMaskCount), childMaskCount: \(county.childMaskCount), pharmacies count: \(county.pharmacies.count)")
        }
    }.disposed(by: disposeBag)

    setupSubViews()
    activityIndicator.startAnimating()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchContentTrigger.onNext(())
//    print(">>>>> start time: \(Date())")
  }

  // MARK: - Private Methods

  private func bindViewModel() {
    viewModel = CountryViewModel()

    guard let viewModel = self.viewModel else { return }
    let input = CountryViewModel.Input(fetchContentTrigger: fetchContentTrigger)
    let output = viewModel.transform(input: input)

    output.items
      .asObservable()
      .subscribe(onNext: { (items) in
        print("item count: ", items.count)
        print(">>>>> end time: \(Date())")
//        items.forEach { (item) in
//          print(">>>>> item name: ", item.name)
//        }
        self.activityIndicator.stopAnimating()
      }).disposed(by: disposeBag)

    output.loadError
      .asObservable()
      .subscribe { (error) in
        print(">>>>> error: ", error.element?.localizedDescription)
    }.disposed(by: disposeBag)
  }

  private func setupSubViews() {
    view.addSubview(activityIndicator)

    activityIndicator.snp.makeConstraints {
      $0.centerX.centerY.equalTo(self.view)
    }
  }
}


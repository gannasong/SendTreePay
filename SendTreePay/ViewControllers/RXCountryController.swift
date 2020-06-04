//
//  RXCountryController.swift
//  SendTreePay
//
//  Created by SUNG HAO LIN on 2020/5/29.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

class RXCountryController: UIViewController {
  private let cellId = "cellId"
  private var viewModel: CountryViewModel?
  private let fetchContentTrigger = PublishSubject<Void>()
  private let disposeBag = DisposeBag()
  private var dataSource: RxTableViewSectionedReloadDataSource<CountySection>?

  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    return tableView
  }()

  lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .lightGray
    activityIndicator.startAnimating()
    return activityIndicator
  }()

  lazy var refreshButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Mask List"
    setupTableView()
    setupIndicator()
    bindViewModel()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchContentTrigger.onNext(())
  }

  // MARK: - Private Methods

  private func setupTableView() {
    view.backgroundColor = .systemGray3
    navigationItem.rightBarButtonItem = refreshButton

    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.size.equalTo(view)
    }
  }

  private func configureCell(for cell: UITableViewCell, with county: County) {
    cell.textLabel?.text = county.name
    cell.detailTextLabel?.text = "成人口罩共 \(county.adultMaskCount) 片"
  }

  private func bindViewModel() {
    viewModel = CountryViewModel()
    guard let viewModel = self.viewModel else { return }
    let refreshTrigger = Observable.of(fetchContentTrigger.asObserver(),
                                       refreshButton.rx.tap.asObservable()).merge()
    let input = CountryViewModel.Input(fetchContentTrigger: refreshTrigger)
    let output = viewModel.transform(input: input)

    dataSource = RxTableViewSectionedReloadDataSource<CountySection>(configureCell: { dataSource, tableView, indexPath, item in
      let cell = UITableViewCell(style: .value1, reuseIdentifier: self.cellId)
      self.configureCell(for: cell, with: item)
      return cell
    })

    output.items
      .map { [CountySection(items: $0)] }
      .bind(to: tableView.rx.items(dataSource: dataSource!))
      .disposed(by: disposeBag)

    output.loadError
      .asObservable()
      .subscribe { (error) in
        print(">>>>> error: ", error.element?.localizedDescription)
    }.disposed(by: disposeBag)

    output.isLoading
      .asDriver()
      .drive(activityIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
  }

  private func setupIndicator() {
    view.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints {
      $0.centerX.centerY.equalTo(view)
    }
  }
}


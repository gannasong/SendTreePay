//
//  SendTreePayTests.swift
//  SendTreePayTests
//
//  Created by SUNG HAO LIN on 2020/5/29.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import RxBlocking
import RxTest

@testable import SendTreePay

class SendTreePayTests: XCTestCase {

  var viewModel: CountryViewModel!
//  var fetchContentTrigger: Observable<Void>!
  var input: CountryViewModel.Input!
  var output: CountryViewModel.Output!
  var disposeBag: DisposeBag!
  var scheduler: TestScheduler!

  override func setUp() {
    super.setUp()
    viewModel = CountryViewModel()
    scheduler = TestScheduler(initialClock: 0, resolution: 0.1)
    disposeBag = DisposeBag()
    input = CountryViewModel.Input(fetchContentTrigger: PublishSubject<Void>().asObservable())
    output = viewModel.transform(input: input)
  }

  // MARK: - RxBlocking

  func testOutputIsLoadingIsTrue() throws {
    XCTAssertEqual(try output.isLoading.toBlocking().first(), true)
  }

  // MARK: - RxTest

}

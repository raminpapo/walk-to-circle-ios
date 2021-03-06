//
//  iiDateFormatterTests.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 30/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import WalkToCircle
import XCTest

class iiDateTests: XCTestCase {
  func testGetDateAsString() {
    let date = iiDate.fromYearMonthDay(2072, month: 4, day: 7)!
    let result = iiDate.toStringAsYearMonthDay(date)
    XCTAssertEqual("2072.4.7", result)
  }

  func testGetDateFromYearMonthDay() {
    let date = iiDate.fromYearMonthDay(2017, month: 12, day: 26)!
    let result = iiDate.toStringAsYearMonthDay(date)
    XCTAssertEqual("2017.12.26", result)
  }
}
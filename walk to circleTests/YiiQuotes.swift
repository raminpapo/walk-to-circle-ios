//
//  YiiQuotes.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 24/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import WalkToCircle
import XCTest

class YiiQuotesTests: XCTestCase {
  func testShowRandomQuote() {
    let expectation = expectationWithDescription("quote is shown")

    let obj = YiiQuotes()

    let textLabel = UILabel()
    obj.textLabel = textLabel

    let authorLabel = UILabel()
    obj.authorLabel = authorLabel

    WalkUserDefaults.anyCircleReached.save(true)

    obj.showRandomQuote {
      XCTAssertEqual(false, textLabel.text!.isEmpty)
      XCTAssertEqual(false, authorLabel.text!.isEmpty)

      XCTAssertNotEqual(WalkConstants.tutorialText, textLabel.text!)

      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(0.05, handler: nil)
  }

  func testShowTutorialMessageWhenRandomQuoteIsNotReached() {
    let obj = YiiQuotes()

    let textLabel = UILabel()
    obj.textLabel = textLabel

    let authorLabel = UILabel()
    obj.authorLabel = authorLabel
    WalkUserDefaults.anyCircleReached.save(false)

    obj.showRandomQuote()

    XCTAssertEqual(WalkConstants.tutorialText, textLabel.text!)
    XCTAssertEqual(WalkConstants.tutorialAuthor, authorLabel.text!)
  }
}

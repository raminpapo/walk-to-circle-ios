//
//  CongratsViewController.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

class CongratsViewController: UIViewController {
  @IBOutlet weak var congratsLabel: UILabel!
  @IBOutlet weak var ciclesReachedLabel: UILabel!

  private var shownMessagesAndPlayedSounds = false

  private let congratsSounds = CongratsSounds()

  override func viewDidLoad() {
    super.viewDidLoad()

    if WalkCirlesReachedToday.number == 0 {
      WalkViewControllers.Map.show(animate: false)
      return
    }

    congratulate()
    showNumberOfCirclesReachedToday()
    congratsLabel.alpha = 0
    ciclesReachedLabel.alpha = 0

    showMessagesAndPlaySound()
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }

  private func congratulate() {
    let numberOfCirclesReachedToday = WalkCirlesReachedToday.number
    let phrase = CongratsPhrase.oneRandomPhrase(numberOfCirclesReachedToday)
    congratsLabel.text = phrase
  }

  private func showMessagesAndPlaySound() {
    if shownMessagesAndPlayedSounds { return }
    shownMessagesAndPlayedSounds = true

    fadeInLabels()
    congratsSounds.play()
  }

  private func showNumberOfCirclesReachedToday() {
    let numberOfCirclesReachedToday = WalkCirlesReachedToday.number

    if numberOfCirclesReachedToday == 1 {
      ciclesReachedLabel.text = "You've reached your first circle today."
    } else {
      ciclesReachedLabel.text = "\(numberOfCirclesReachedToday) circles reached today."
    }
  }

  private func fadeInLabels() {
    iiAnimator.fadeInSpring(congratsLabel, duration: WalkConstants.textFadeInDuration, delay: 0.2)
    iiAnimator.fadeInSpring(ciclesReachedLabel, duration: WalkConstants.textFadeInDuration, delay: 0.2)
  }


  @IBAction func onDoneTapped(sender: AnyObject) {
    congratsSounds.stop()
    WalkViewControllers.Map.show()
  }
}
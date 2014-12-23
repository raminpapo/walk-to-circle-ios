//
//  RewindButton.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 19/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import QuartzCore

class RewindButton: UIButton {
  private let countdownLabel = UILabel()

  private let iiFont = UIFont.systemFontOfSize(40)

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    initLabel()
    showArrows()
  }

  func updateText(text: String) {
    let attributedText = NSAttributedString(string: text, attributes: [
      NSForegroundColorAttributeName: WalkColors.ButtonTextColor.uiColor,
      NSFontAttributeName: iiFont,
      NSTextEffectAttributeName: NSTextEffectLetterpressStyle
      ])

    countdownLabel.attributedText = attributedText
  }

  private func initLabel() {
    countdownLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

    RewindButton.positionContdownLabel(self, label: countdownLabel)
  }

  private func showArrows() {
    let arrowsLayer = CALayer()
    iiLayer.loadImage(inLayer: arrowsLayer, imageName: "rewind_arrows")
    iiLayer.centerInParent_withSizeOfParent(arrowsLayer, parentBounds: bounds)
    self.layer.addSublayer(arrowsLayer)

    RewindButton.rotateArrows(arrowsLayer)
  }

  private class func rotateArrows(layer: CALayer) {
    let keyPath = "transform.rotation.z"
    iiAnimator.addInfiniteAnimation(layer, keyPath: keyPath,
      fromVaue: 0, toValue: -M_PI, duration: 1, autoreverses: false)
  }

  private class func positionContdownLabel(superview: UIView, label: UILabel) {
    superview.addSubview(label)

    superview.addConstraint(NSLayoutConstraint(
      item: superview,
      attribute: NSLayoutAttribute.CenterX,
      relatedBy: NSLayoutRelation.Equal,
      toItem: label,
      attribute: NSLayoutAttribute.CenterX,
      multiplier: 1,
      constant: 0))

    superview.addConstraint(NSLayoutConstraint(
      item: superview,
      attribute: NSLayoutAttribute.CenterY,
      relatedBy: NSLayoutRelation.Equal,
      toItem: label,
      attribute: NSLayoutAttribute.CenterY,
      multiplier: 1,
      constant: 0))
  }
}

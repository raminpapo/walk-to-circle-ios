//
//  WalkLocation.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import CoreLocation

let iiWalkLocation = WalkLocation()

class WalkLocation {
  private let locationManager = CLLocationManager()

  class var shared: WalkLocation {
    return iiWalkLocation
  }

  private init() { }

  func requestAuthorization() {
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }
  }
}

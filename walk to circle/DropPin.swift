//
//  PlacePin.swift
//
//  Class function that place pin on the map
//
//  Created by Evgenii Neumerzhitckii on 12/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

class DropPin {
  class func dropNewPinAndAnimate(mapView: MKMapView, coordinate: CLLocationCoordinate2D) {

    let annotationTitle = NSLocalizedString("Walk to circle",
      comment: "Annotation title shown above the pin on the map")

    let annotation = Annotations.show(coordinate, title: annotationTitle, newPin: true, mapView: mapView)

    if annotation.showCalloutAfterPinDrop {
      mapView.selectAnnotation(annotation, animated: true)
    }
  }

  class func showPreviousPin(mapView: MKMapView, coordinate: CLLocationCoordinate2D) {

    let annotationTitle = NSLocalizedString("Previous circle",
      comment: "Annotation title for previous pin")

    Annotations.show(coordinate, title: annotationTitle, newPin: false, mapView: mapView)
  }

  class func playPinDropSound(pindDropHeight: CGFloat) {
    if pindDropHeight == 0 { return }

    if pindDropHeight > 200 {
      iiSounds.shared.play(iiSoundType.fall, atVolume: 0.1)
    }

    let pinDropSoundDelay = pow(Double(pindDropHeight) / 1500.0, 2) + 0.2

    iiQ.runAfterDelay(pinDropSoundDelay) {
      iiSounds.shared.play(iiSoundType.pin_drop, atVolume: 0.8)
    }
  }
}

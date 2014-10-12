//
//  ViewController.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 6/07/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit
import QuartzCore

class ViewController: UIViewController, MKMapViewDelegate, iiOutputViewController {

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var outputLabel: UILabel!
  @IBOutlet weak var startButton: UIButton!

  private var locationManager: CLLocationManager!
  private var zoomedToInitialLocation = false
  private var annotations: Annotations!
  private var callbackAfterRegionDidChange: (()->())?

  private var pindDropHeight: CGFloat = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    annotations = Annotations(mapView)

    initMapView()
  }

  private func initMapView() {
    mapView.delegate = self
    mapView.showsUserLocation = true
  }

  private func showStartButton() {
    startButton.hidden = false
    iiSounds.shared.play(iiSoundType.blop, atVolume: 0.1)
    Animator().bounce(startButton)
  }

  // Extract: Place pin: 1
  func placeCircleOnMap() {
    annotations.removeAll()

    let coordinate = iiGeo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceKm: 1, maxDistanceKm: 3)

    if InitialMapZoom.needZoomingBeforePlay(mapView) {
      doAfterRegionDidChange {
        iiQ.runAfterDelay(0.3) {
          self.placePin(coordinate)
        }
      }

      InitialMapZoom.zoomToLocation(mapView, userLocation: mapView.userLocation, animated: true)
    } else {
      self.placePin(coordinate)
    }
  }

  // Extract: Place pin
  func placePin(coordinate: CLLocationCoordinate2D) {
    let scrollNeeded = ScrollToAnnotation.scrollNeededToSeeAnnotation(mapView,
      startButton: startButton, willDropAt: coordinate)

    let coordinateInView = mapView.convertCoordinate(coordinate, toPointToView: mapView)
    pindDropHeight =  coordinateInView.y - scrollNeeded.height

    ScrollToAnnotation.scrollMap(scrollNeeded, mapView: mapView) {
      self.placeCircleOnMapAndAnimate(coordinate)
    }
  }

  // Extract: Place pin
  func placeCircleOnMapAndAnimate(coordinate: CLLocationCoordinate2D) {
    let annotationTitle = NSLocalizedString("Memorize & walk here",
      comment: "Annotation title shown above the pin on the map")

    let annotationSubtitle = NSLocalizedString("The map will close in 60 sec",
      comment: "Annotation title shown above the pin on the map")

    let annotation = annotations.add(coordinate, id: annotationTitle,
      subtitle: annotationSubtitle)

    mapView.selectAnnotation(annotation, animated: true)
    Annotation.hideCalloutAfterDelay(mapView, annotation: annotation, delay: 5)
  }

  @IBAction func onPlay() {
    placeCircleOnMap()
  }

  private func playPinDropSound() {
    if pindDropHeight == 0 { return }

    if pindDropHeight > 200 {
      iiSounds.shared.play(iiSoundType.fall, atVolume: 0.01)
    }

    var showPinAfterDelay = pow(Double(pindDropHeight) / 1200.0, 2.5)

    if showPinAfterDelay < 0.2 { showPinAfterDelay = 0.2 }

    iiQ.runAfterDelay(showPinAfterDelay) {
      iiSounds.shared.play(iiSoundType.ballBounce, atVolume: 0.5)
    }
  }

  private func zoomToInitialLocation() {
    if zoomedToInitialLocation { return }

    InitialMapZoom.zoomToInitialLocation(mapView) {
      self.zoomedToInitialLocation = true
      self.showStartButton()
    }
  }
}

// MapView Delegate
// ------------------------------

typealias VCExtensionMapViewDelegate = ViewController

extension VCExtensionMapViewDelegate {
  func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
    zoomToInitialLocation()
  }

  func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
    if (animated) { return }

    if let cb = callbackAfterRegionDidChange {
      iiQ.runAfterDelay(0.3, cb)
    }
    callbackAfterRegionDidChange = nil
  }

  func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
    callbackAfterRegionDidChange?()
    callbackAfterRegionDidChange = nil
  }

  func doAfterRegionDidChange(callback: ()->()) {
    callbackAfterRegionDidChange = callback
  }

  func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
    playPinDropSound()
  }
}


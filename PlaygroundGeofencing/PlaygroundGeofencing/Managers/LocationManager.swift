//
//  LocationManager.swift
//  PlaygroundGeofencing
//
//  Created by Killian Sowa on 08/07/2021.
//

import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    let notificationManager = LocalNotificationManager()
    private let geofenceRegionCenter = CLLocationCoordinate2DMake(45.90908871425869, 6.104119273581125)
    @Published var location: CLLocation?
    @Published var currentIdentifier: String = ""
    
    override init() {
        super.init()
        
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 40, identifier: "Parc de malade")
        geofenceRegion.notifyOnEntry = true
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoring(for: geofenceRegion)
        locationManager.delegate = self

    }
    
    private func launchNotifications(notifications: [Notification]) {
        notificationManager.notifications = notifications

        notificationManager.startRideNotifications()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.location = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("i enter in your fucking region")
        
        launchNotifications(notifications: [
            Notification(id: "geotification-\(region.identifier)", title: "😯 Des oeuvres sont proches de vous", body: "Vous approchez du lieu : \(region.identifier)", triggerDelay: 4),
        ])
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
      let status = manager.authorizationStatus
              //mapView.showsUserLocation = (status == .authorizedAlways)

      if status != .authorizedAlways {
        let message = """
        Your geotification is saved but will only be activated once you grant
        Geotify permission to access the device location.
        """
        //showAlert(withTitle: "Warning", message: message)
      }
    }
}

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
    private let geofenceRegionCenter = CLLocationCoordinate2DMake(45.90825675728927, 6.103226194101166)
    @Published var location: CLLocation?
    @Published var isPresentedAlert: Bool = false
    @Published var currentIdentifier: String = ""
    
    override init() {
        super.init()
        
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 80, identifier: "CrazyParc")
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
        print(region.identifier)
        if region.identifier == "CrazyParc" {
            isPresentedAlert = true
            
            launchNotifications(notifications: [
                Notification(id: "geotificationin-\(region.identifier)", title: "😯 Des oeuvres sont proches de vous", body: "Vous approchez du lieu : \(region.identifier)", triggerDelay: 1),
            ])
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print(region.identifier)
        if region.identifier == "CrazyParc" {
            isPresentedAlert = false
            
            launchNotifications(notifications: [
                Notification(id: "geotificationout-\(region.identifier)", title: "Vous vous éloignez", body: "Mais quel dommage !", triggerDelay: 1),
            ])
        }
    }
}

//
//  ContentView.swift
//  PlaygroundGeofencing
//
//  Created by Killian Sowa on 07/07/2021.
//

import Combine
import SwiftUI
import MapKit

struct ContentView: View {
    @State var region = defaultRegion
    @ObservedObject private var locationManager = LocationManager()

    @State private var cancellable: AnyCancellable?
    
    private func setCurrentLocation() {
        cancellable = locationManager.$location.sink { location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
    
    var body: some View {

        VStack {
            if locationManager.isPresentedAlert {
                Text("locateddd \(locationManager.currentIdentifier)")
            }

            if locationManager.location != nil {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil)
            } else {
                Text("Locating user locartion..")
            }
        }
        .onAppear {
            setCurrentLocation()
        }
    }
}

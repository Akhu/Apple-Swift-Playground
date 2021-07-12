//
//  MapView.swift
//  PlaygroundGeofencing
//
//  Created by Killian Sowa on 07/07/2021.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var tracking: MapUserTrackingMode = .follow
    @State var manager = CLLocationManager()
    @StateObject var managerDelegate = locationDelegate()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("hasSomeKindOfPermission")
                    if manager.authorizationStatus == .authorizedWhenInUse {
                        Text("true")
                    } else {
                        Text("false")
                    }
                }

                HStack {
                    Text("gettingExactLocation")
                    if managerDelegate.gettingExactLocation {
                        Text("true")
                    } else {
                        Text("false")
                    }
                }

            }

            Map(coordinateRegion: $region)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }.onAppear(perform: {
            manager.delegate = managerDelegate
            manager.requestAlwaysAuthorization()
        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class locationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @State var hasSomeKindOfPermission: Bool = false
    @State var gettingExactLocation: Bool = false
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            self.hasSomeKindOfPermission = true
        case .notDetermined, .denied, .restricted:
            self.hasSomeKindOfPermission = false
        default: print("Unhandled case")
        }
        
        switch manager.accuracyAuthorization {
        case .reducedAccuracy:
            gettingExactLocation = false
        case .fullAccuracy:
            gettingExactLocation = true
        default: print("this should'nt happen!")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new locations")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("cc")
    }
}


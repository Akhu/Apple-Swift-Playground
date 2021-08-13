//
//  MapKitWithLocation.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 13/08/2021.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapKitWithLocation: View {
    
    @StateObject var permissions = Permissions()
    
    @State private var userTrackingMode: MapUserTrackingMode = .none
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 25.7617,
            longitude: 80.1918
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10
        )
    )

    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Map(
                coordinateRegion: $region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode
            )
            Button(action: {
                if permissions.notificationPermissionState == .denied {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!)!, options: [:], completionHandler: nil)
                } else {
                    permissions.askForLocalizationPermission()
                    withAnimation(.spring()) {
                        centerRegionOnUser()
                    }
                }
            }, label: {
                Image(systemName: "location.fill.viewfinder")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous))
            })
            .padding()
            .frame(alignment: .topLeading)
        }.onReceive(permissions.$localizationPermissionState, perform: { _ in
            centerRegionOnUser()
        })
    }
    
    func centerRegionOnUser() {
        if permissions.localizationPermissionState != .denied || permissions.localizationPermissionState == .notDetermined {
            userTrackingMode = .follow
            if let currentLocation = permissions.locationManager.location {
                region = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(
                    latitudeDelta: 10,
                    longitudeDelta: 10
                ))
            }
        }
    }
}

struct MapKitWithLocation_Previews: PreviewProvider {
    static var previews: some View {
        MapKitWithLocation()
    }
}

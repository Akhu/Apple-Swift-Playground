//
//  MapKitWithLocation.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 13/08/2021.
//

import SwiftUI
import CoreLocation
import MapKit
let rawRegions = [
    ("Pont des amours",45.91044837855673, 6.143521781870996),
    ("Impérial",45.90321919886301, 6.143944298920628),
    ("Debut du paquier", 45.90324336895755, 6.1367544600225115),
    ("Sculpture Paquier", 45.90176897379019, 6.134218913041331),
    ("Oeuvre JE1", 45.89971442362796, 6.1307802944378835),
    ("Oeuvre JE2", 45.899061785901296, 6.13196123416028),
    ("Oeuvre JE3", 45.89993196783216, 6.129390953588006),
    ("Oeuvre JE4", 45.89846507020296, 6.130153050894414),
    ("Oeuvre JE5", 45.89912813616961, 6.130445031782466),
    ("Lotus", 45.899491749638024, 6.128739248690086),
    ("Vieille Ville 1", 45.89948105514886, 6.1256503982523345)
]

struct AnnotationItem: Identifiable, Equatable {
    var id: String
    var lat: Double
    var lon: Double
    var isMonitored: Bool = false
}

var annotationItemsFromRawRegion : [AnnotationItem] {
    get {
        return rawRegions.map({ AnnotationItem(id: $0.0, lat: $0.1, lon: $0.2) })
    }
}

struct MapKitWithLocation: View {
    
    @StateObject var permissions = Permissions()
    
    var annotationsItems: [AnnotationItem]
    
    @Binding var selectedItem: AnnotationItem?
    
    @State private var userTrackingMode: MapUserTrackingMode = .none
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 45.91044837855673,
            longitude: 6.143521781870996
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )

    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Map(
                coordinateRegion: $region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode,
                annotationItems: annotationsItems
            ) { item -> MapAnnotation<Button> in
                return MapAnnotation(
                    coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.lon),
                    anchorPoint: CGPoint(x: 0.5, y: 0.5)
                ) {
                    Button(action: {
                        selectedItem = item
                    }, label: {
                        AnyView(Image(systemName: "circle.fill")
                           .frame(width: 5, height: 5, alignment: .center)
                           .foregroundColor(.blue))
                    })
                }
            }
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
    
    var isLocationEnabled: Bool {
        return permissions.locationManager.location != nil
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
        MapKitWithLocation( annotationsItems: annotationItemsFromRawRegion, selectedItem: .constant(nil))
    }
}

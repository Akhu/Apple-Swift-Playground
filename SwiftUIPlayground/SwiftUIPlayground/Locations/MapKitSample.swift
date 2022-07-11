//
//  MapView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 23/06/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var userTrackingMode: MapUserTrackingMode = .follow
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
        Map(
            coordinateRegion: $region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode
        )
    }
}

struct MapExample: View {
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
        VStack {
            Map(coordinateRegion: $region)

            Button("zoom") {
                withAnimation {
                    region.span = MKCoordinateSpan(
                        latitudeDelta: 100,
                        longitudeDelta: 100
                    )
                }
            }
        }
    }
}

struct MapExample2: View {
    @State private var userTrackingMode: MapUserTrackingMode = .follow
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
        Map(
            coordinateRegion: $region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode
        )
    }
}


struct City: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapExample3: View {
    @State private var cities: [City] = [
        City(coordinate: .init(latitude: 40.7128, longitude: 74.0060)),
        City(coordinate: .init(latitude: 37.7749, longitude: 122.4194)),
        City(coordinate: .init(latitude: 47.6062, longitude: 122.3321))
    ]

    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: 122.4194),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )

    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: cities) { city in
                MapMarker(coordinate: city.coordinate, tint: .green)
            }
            
            Map(coordinateRegion: $region, annotationItems: cities) { city in
                MapAnnotation(
                    coordinate: city.coordinate,
                    anchorPoint: CGPoint(x: 0.5, y: 0.5)
                ) {
                    VStack {
                        Image(systemName: "pencil.slash")
                        Circle()
                            .stroke(Color.green)
                            .frame(width: 44, height: 44)
                    }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
//        MapExample3()
//        MapView()
//        MapExample()
        MapExample2()
    }
}

//
//  PermissionsExtensions.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 13/08/2021.
//

import Foundation
import CoreLocation
import UserNotifications
import Combine

extension CLLocationManager {
    func getLocalizationPermissionStatus() -> Future<CLAuthorizationStatus, Never> {
        return Future { promise in
            promise(.success(self.authorizationStatus))
        }
    }
}




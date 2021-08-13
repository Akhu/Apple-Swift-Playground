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


extension UNUserNotificationCenter {
    func getNotificationSettings() -> Future<UNNotificationSettings,
                                             Never> {
        return Future { promise in
            self.getNotificationSettings { settings in promise(.success(settings))
            } }
    }
    func requestAuthorization(options: UNAuthorizationOptions) ->
    Future<Bool, Error> { return Future { promise in
        self.requestAuthorization(options: options) { result, error in if let error = error {
            promise(.failure(error)) } else {
                promise(.success(result))
            }
        } }
    } }

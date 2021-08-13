//
//  Permissions.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 13/08/2021.
//

import Foundation
import Combine
import CoreLocation
import UserNotifications
import SwiftUI

class Permissions: NSObject, ObservableObject {
    
    @Published var notificationPermissionState : UNAuthorizationStatus = .notDetermined
    @Published var localizationPermissionState : CLAuthorizationStatus = .notDetermined
    
    @Published var canLaunch: Bool = false
    
    
    private let defaults = UserDefaults.standard
    var locationManager = CLLocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
                
        Publishers.CombineLatest($notificationPermissionState, $localizationPermissionState)
            .map { (notificationStatus, localizationStatus) -> Bool in
                if notificationStatus == .notDetermined || notificationStatus == .denied {
                    return false
                }
                
                if localizationStatus == .denied || localizationStatus == .notDetermined {
                    return false
                }
                
                return true
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.canLaunch, on: self)
            .store(in: &cancellables)
        
        loadPermissions()
    }

    func loadPermissions(){
        UNUserNotificationCenter.current()
            .getNotificationSettings()
            .flatMap { settings -> AnyPublisher<UNAuthorizationStatus, Never> in
                return Just(settings.authorizationStatus).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.notificationPermissionState, on: self)
            .store(in: &cancellables)
        
        locationManager
            .getLocalizationPermissionStatus()
            .assign(to: \.localizationPermissionState, on: self)
            .store(in: &cancellables)
    }
    
    func askForLocalizationPermission() {
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func askForNotificationPermission(){
        UNUserNotificationCenter.current().getNotificationSettings()
            .flatMap { settings -> AnyPublisher<UNAuthorizationStatus, Never> in
                switch settings.authorizationStatus {
                case .notDetermined:
                    return UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
                        .replaceError(with: false)
                        .map({ askingResult in
                            if askingResult {
                                return UNAuthorizationStatus.authorized
                            } else {
                                return UNAuthorizationStatus.denied
                            }
                        })
                        .eraseToAnyPublisher()
                default:
                    return Just(settings.authorizationStatus)
                        .eraseToAnyPublisher()
                }
            }.receive(on: DispatchQueue.main)
            .assign(to: \.notificationPermissionState, on: self)
            .store(in: &cancellables)
    }
    
    func askForAllPermissions(){
        self.askForNotificationPermission()
        self.askForLocalizationPermission()
    }
}

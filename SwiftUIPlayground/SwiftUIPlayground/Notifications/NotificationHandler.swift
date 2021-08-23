//
//  NotificationHandler.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 16/08/2021.
//

import Foundation
import UserNotifications
import Combine

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    
    @Published var notification: UNNotificationContent?
    
    @Published var notificationPermissionState: UNAuthorizationStatus = .notDetermined
    
    var cancellables = Set<AnyCancellable>()
    
    static let shared = NotificationHandler()
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let notificationName = Notification.Name(response.notification.request.identifier)
        self.notification = response.notification.request.content
        NotificationCenter.default.post(name:notificationName , object: response.notification.request.content)
        
        
        completionHandler()
    }
    
    /**
     When app is in foreground
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let notificationName = Notification.Name(notification.request.identifier)
        NotificationCenter.default.post(name:notificationName , object: notification.request.content)
        self.notification = notification.request.content
        completionHandler([.banner,.sound])
    }
    
    /**
     Ask for notification permissions and store result in NotificationHandler
     */
    func askForNotificationPermission() {
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

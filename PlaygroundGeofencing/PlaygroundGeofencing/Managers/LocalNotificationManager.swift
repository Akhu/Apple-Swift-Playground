//
//  LocalNotificationManager.swift
//  PlaygroundGeofencing
//
//  Created by Killian Sowa on 09/07/2021.
//

import UserNotifications

class LocalNotificationManager
{
    var notifications = [Notification]()
    
    private func scheduleNotifications()
    {
        for notification in notifications
        {
            let content      = UNMutableNotificationContent()
            content.title    = notification.title
            content.body = notification.body
            content.sound    = .default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notification.triggerDelay, repeats: false)

            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }

                print("Notification scheduled! --- ID = \(notification.id)")
            }
        }
    }
    
    func startRideNotifications()
    {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
                
            default:
                break
            }
        }
    }
    
    private func requestAuthorization()
    {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }
    
}

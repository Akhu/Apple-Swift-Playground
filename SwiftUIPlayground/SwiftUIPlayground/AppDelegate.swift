//
//  AppDelegate.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 16/08/2021.
//

import Foundation
import UIKit
import SwiftUI
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //Delegate the UNUserNotification to some Class
        //https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate
        UNUserNotificationCenter.current().delegate = NotificationHandler.shared
        return true
    }

}

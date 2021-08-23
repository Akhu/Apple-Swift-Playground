//
//  SwiftUIPlaygroundApp.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 19/07/2021.
//

import SwiftUI

@main
struct SwiftUIPlaygroundApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    NavigationLink("Permissions", destination:  PermissionsWithCombine())
                    NavigationLink("Local Notification Tester", destination:  LocalNotificationView())
                    NavigationLink("Bottom Sheet", destination:  BottomSheetViewSample())
                    NavigationLink("Scroll View Fixed Element", destination:  ScrollViewFixedElement())
                }
            }
            
        }
    }
}

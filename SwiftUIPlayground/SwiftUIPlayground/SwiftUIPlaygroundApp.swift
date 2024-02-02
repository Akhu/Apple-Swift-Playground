//
//  SwiftUIPlaygroundApp.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 19/07/2021.
//

import SwiftUI
enum Page {
    case home, permissions, notification, bottomSheet, scrollView
}

@main
struct SwiftUIPlaygroundApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isPermissionPageActive = false

    var body: some Scene {
        WindowGroup {
            MainMenu()
        }
    }
}

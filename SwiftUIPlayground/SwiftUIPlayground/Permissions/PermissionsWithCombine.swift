//
//  PermissionsWithCombine.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 08/08/2021.
//

import SwiftUI
import Combine
import CoreLocation
import UserNotifications

struct PermissionsWithCombine: View {
    
    
    @StateObject var permissions = Permissions()
    
    var body: some View {
        VStack {
            Toggle(isOn: $permissions.canLaunch, label: {
                Text("CanLaunch")
            }).onChange(of: permissions.canLaunch, perform: { value in
                permissions.loadPermissions()
            })
            Button(action: {
                if permissions.notificationPermissionState == .denied {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!)!, options: [:], completionHandler: nil)
                }
                permissions.askForAllPermissions()
            }, label: {
                if permissions.notificationPermissionState != .authorized {
                    Text("Ask for Permissions")
                } else {
                    Text("Permissions Granted !")
                }
            }).onAppear {
                permissions.loadPermissions()
            }
            if permissions.canLaunch {
                Text("LESSSGGOOOOOOO")
            }
            
        }
    }
}

struct PermissionsWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsWithCombine()
    }
}



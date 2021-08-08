//
//  PermissionsWithCombine.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 08/08/2021.
//

import SwiftUI
import Combine

class PermissionsState: ObservableObject {
    
    @Published var permissionStatus : Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func askForPermissions(){
        UNUserNotificationCenter.current().getNotificationSettings()
            .flatMap { settings -> AnyPublisher<Bool, Never> in
                switch settings.authorizationStatus {
                case .notDetermined:
                    return UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
                        .replaceError(with: false)
                        .eraseToAnyPublisher()
                case .denied:
                    return Just(false).eraseToAnyPublisher()
                case .authorized:
                    return Just(true).eraseToAnyPublisher()
                case .provisional:
                    return Just(true).eraseToAnyPublisher()
                case .ephemeral:
                    return Just(true).eraseToAnyPublisher()
                @unknown default:
                    return Just(false).eraseToAnyPublisher()
                }
            }.receive(on: DispatchQueue.main)
            .assign(to: \.permissionStatus, on: self)
            .store(in: &cancellables)
        
    }
}

struct PermissionsWithCombine: View {
    
    @StateObject var permissionState = PermissionsState()
    
    var body: some View {
        Button(action: {
            permissionState.askForPermissions()
        }, label: {
            if permissionState.permissionStatus == false {
                Text("Ask for Permissions")
            } else {
                Text("Permissions Granted !")
            }
            
        })
    }
}

struct PermissionsWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsWithCombine()
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

//
//  LocalNotificationView.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 16/08/2021.
//

import SwiftUI



class LocalNotifications
{
    
    static let notificationInfoKey = "testNotification"
    //TODO: Open the artwork
    
    static func buildNotificationContentWithAttachment(id: String, attachmentImage: URL, completion: @escaping (UNNotificationAttachment?) -> (Void)){
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: attachmentImage), completionHandler: { data,urlResponse,error in
                    if let dataImage = data {
                        let urlToImage =  FileManager.default.temporaryDirectory.appendingPathComponent("notificationImage").appendingPathExtension("jpg")
                        
                        try? dataImage.write(to: urlToImage, options: .atomic)
                        if let attachment = try? UNNotificationAttachment(identifier: "imageNotification", url: urlToImage, options: nil) {
                            completion(attachment)
                        } else {
                            completion(nil)
                        }
                        
                    }else {
                        completion(nil)
                    }
                })
        task.resume()
    }
    static func launchNotification(id: String, attachmentImage: URL? = nil) {
        if let attachmentImageUrl = attachmentImage {
            buildNotificationContentWithAttachment(id: id, attachmentImage: attachmentImageUrl) { attachmentNotification in
                
                let content = UNMutableNotificationContent()
                if let attachmentHydrated = attachmentNotification {
                    content.attachments.append(attachmentHydrated)
                }
                content.title = "Test Notification"
                content.body = "This is a test 🔥"
                
                content.sound = .default
                content.userInfo = [notificationInfoKey : id]
                
                //Someday : Handle Image in notifications --> https://newbedev.com/unnotificationattachment-with-uiimage-or-remote-url

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
                
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    guard error == nil else { return }
                    print("Notification scheduled! --- ID = \(id)")
                }
            }
        } else {
            let content = UNMutableNotificationContent()
        
            content.title = "Test Notification"
            content.body = "This is a test 🔥"
            
            content.sound = .default
            content.userInfo = [notificationInfoKey : id]
            
            //Someday : Handle Image in notifications --> https://newbedev.com/unnotificationattachment-with-uiimage-or-remote-url

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Notification scheduled! --- ID = \(id)")
            }
        }
    }
}

struct LocalNotificationView: View {
    
    let notificationName = "someIdentifierForThisNotification"
    
    var body: some View {
        VStack {
            Button(action: {
                LocalNotifications.launchNotification(id: self.notificationName, attachmentImage: URL(string: "https://picsum.photos/id/237/500/500")!)
            }, label: {
                Text("Launch Local Notification")
            })
        }.onReceive(NotificationHandler.shared.$notification, perform: { data in
             print(data?.userInfo)
             print("title:\(data?.title), subtitle:\(data?.subtitle)")
        })
    }
}

struct LocalNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationView()
    }
}

//
//  TimerViewModel.swift
//  Babysistant
//
//  Created by Victor Monteiro on 4/9/21.
//

import UIKit
import UserNotifications

class TimerViewModel {
    
    
    func requestNotification() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            
            if granted {
                
                print(" 🟢 Permission granted")
                
            } else {
                
                print("🔴 Permission not granted")
                
            }
            
        }
        
    }
    
    func triggerNotification(title: String, body: String, time: TimeInterval) {
        
        let center = UNUserNotificationCenter.current()
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.categoryIdentifier = "alarm"
        notificationContent.sound = .defaultCritical
        
        print(TimeInterval(time * 60))
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: time * 60 , repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: notificationTrigger)
        
        center.add(request) { error in
            
            if error != nil {
                
                print("🔴 error sending notification \(error?.localizedDescription)")
                
            } else {
                
                print("🟢 notification succesfully send")
                
            }
            
        }
    }
    
    func deactivateNotification() {
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
    }
    
}

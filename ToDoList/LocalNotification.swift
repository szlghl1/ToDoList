//
//  LocalNotification.swift
//  ToDoList
//
//  Created by Ling He on 2/8/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class LocalNotification {
    static func addNotification(forTask: ThingToDo) {
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "\(forTask.title ?? "") is dued.", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "\(forTask.detail ?? "")",
                                                                arguments: nil)
        content.sound = UNNotificationSound.default()
        
        var dateInfo = DateComponents()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: forTask.deadline as! Date)
        let month = calendar.component(.month, from: forTask.deadline as! Date)
        let day = calendar.component(.day, from: forTask.deadline as! Date)
        let hour = calendar.component(.hour, from: forTask.deadline as! Date)
        let min = calendar.component(.minute, from: forTask.deadline as! Date)
        
        dateInfo.year = year
        dateInfo.month = month
        dateInfo.day = day
        dateInfo.hour = hour
        dateInfo.minute = min
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: forTask.uuid!, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    static func removeNotification(forTask: ThingToDo) {
        if forTask.uuid == nil {
            return
        }
        
        let center = UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: [forTask.uuid!])
        center.removePendingNotificationRequests(withIdentifiers: [forTask.uuid!])
    }
    
    static var badgeNumber: Int = 0{
        willSet {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    
    private init() {
        
    }
}

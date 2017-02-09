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
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: , repeats: <#T##Bool#>)
        
        
        let localNoti = UILocalNotification()
        
        let fireDate = forTask.deadline
        localNoti.fireDate = fireDate as Date?
        
        localNoti.alertBody = "\(forTask.title ?? "") is dued."
        localNoti.soundName = UILocalNotificationDefaultSoundName
        localNoti.alertAction = "Open my to do list"
        localNoti.applicationIconBadgeNumber = 1
        
        // information (key-value pair) binding to the notification
        localNoti.userInfo = ["uuid": forTask.uuid!]
        
        UIApplication.shared.scheduleLocalNotification(localNoti)
    }
    
    static func removeNotification(forTask: ThingToDo) -> RemoveResult {
        if forTask.uuid == nil {
            return .fail
        }
        
        if let locals = UIApplication.shared.scheduledLocalNotifications {
            for localNoti in locals {
                if let infoDict = localNoti.userInfo {
                    if infoDict.keys.contains("uuid") && (infoDict["uuid"] as? String) == forTask.uuid! {
                        UIApplication.shared.cancelLocalNotification(localNoti)
                    }
                }
            }
            
            return .notFound
        }
        
        return .fail
    }
    
    private init() {
        
    }
}

enum RemoveResult {
    case succeed
    case notFound
    case fail
}

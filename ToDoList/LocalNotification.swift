//
//  LocalNotification.swift
//  ToDoList
//
//  Created by Ling He on 2/8/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import Foundation

class LocalNotification {
    func addNotification(forTask: ThingToDo) {
        let localNoti = UILocalNotification()
        
        let fireDate = forTask.deadline
        localNoti.fireDate = fireDate
        
        localNoti.alertBody = "\(forTask.title) is dued."
        localNoti.soundName = UILocalNotificationDefaultSoundName
        localNoti.alertAction = "Open my to do list"
        localNoti.applicationIconBadgeNumber = 1
        
        // information (key-value pair) binding to the notification
        localNoti.info = ["uuid": forTask.uuid!]
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNoti)
    }
    
    func removeNotification(forTask: ThingToDo) -> RemoveResult {
        if forTask.uuid == nil {
            return .fail
        }
        
        if let locals = UIApplication.sharedApplication().scheduledLocalNotifications {
            for localNoti in locals {
                if let infoDict = localNoti.info {
                    if dict.keys.contains("uuid") && (dict["uuid"] as? String) == forTask.uuid! {
                        UIApplication.sharedApplication().cancelLocalNotification(localNoti)
                    }
                }
            }
            
            return .notFound
        }
        
        return .fail
    }
}

enum RemoveResult {
    case succeed
    case notFound
    case fail
}

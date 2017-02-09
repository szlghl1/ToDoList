//
//  LocalNotification.swift
//  ToDoList
//
//  Created by Ling He on 2/8/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import Foundation

class LocalNotification {
    func addNotification(at: Date, forTask: ThingToDo) {
        
    }
    
    func removeNotification(forTask: ThingToDo) -> RemoveResult {
        return .fail
    }
}

enum RemoveResult {
    case succeed
    case notFound
    case fail
}

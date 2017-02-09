//
//  ToDoList.swift
//  ToDoList
//
//  Created by Ling He on 2/8/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public let numOfImportLevel:Int = 4

class ToDoList {
    //we don't need singleton, because this class has no property. We can simply declare all methods static
    //don't forget to protect the constructor, since intantiate is meaningless
    
    static let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {
    }
    
    static func addTask(title: String, detail: String, importantLevel: Int = 0, deadline: Date, group:Int = 0) -> ThingToDo? {
        if let task = NSEntityDescription.insertNewObject(forEntityName: "ThingToDo", into: managedContext) as? ThingToDo{
            task.title = title
            task.detail = detail
            task.importantLevel = Int16(importantLevel)
            task.deadline = deadline as NSDate?
            task.group = Int16(group)
            do {
                try managedContext.save()
            } catch {
                print("failed to save context in adding task")
            }
            return task
        }
        return nil
    }
    
    static func removeTask(task: ThingToDo) {
        managedContext.delete(task)
        do {
            try managedContext.save()
        } catch {
            print("failed to save context in deleting")
        }
    }
    
    static func getTasksByImportLevel(importantLevel: Int) -> [ThingToDo] {
        let request:NSFetchRequest<ThingToDo> = ThingToDo.fetchRequest()
        var res: [ThingToDo] = []
        request.predicate = NSPredicate(format: "importantLevel = %d", importantLevel)
        do {
            try res = managedContext.fetch(request)
        } catch {
            print("failed to fetch section \(importantLevel)")
        }
        return res
    }
}

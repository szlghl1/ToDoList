//
//  ThingToDo+CoreDataClass.swift
//  ToDoList
//
//  Created by Ling He on 2/8/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import Foundation
import CoreData

@objc(ThingToDo)
public class ThingToDo: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.createTime = Date() as NSDate?
        self.uuid = UUID().uuidString
    }
}

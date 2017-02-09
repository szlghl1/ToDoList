//
//  ThingToDo+CoreDataProperties.swift
//  ToDoList
//
//  Created by Ling He on 2/8/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import Foundation
import CoreData


extension ThingToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThingToDo> {
        return NSFetchRequest<ThingToDo>(entityName: "ThingToDo");
    }

    @NSManaged public var createTime: NSDate?
    @NSManaged public var deadline: NSDate?
    @NSManaged public var detail: String?
    @NSManaged public var group: Int16
    @NSManaged public var importantLevel: Int16
    @NSManaged public var title: String?
    @NSManaged public var uuid: String?

}

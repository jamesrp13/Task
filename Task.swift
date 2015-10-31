//
//  Task.swift
//  Task
//
//  Created by James Pacheco on 10/26/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Task: NSManagedObject {
    
    convenience init(title: String, dueDate: NSDate? = nil, notes: String? = nil, isComplete: Bool = false, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: context)!
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.title = title
        self.dueDate = dueDate
        self.notes = notes
        self.isComplete = isComplete
        self.dateCreated = NSDate()
    }
}

func ==(lhs: Task, rhs: Task) -> Bool {
    return (lhs.title == rhs.title) && (lhs.notes == rhs.notes) && (rhs.isComplete == rhs.isComplete)
}
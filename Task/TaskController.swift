//
//  TaskController.swift
//  Task
//
//  Created by James Pacheco on 10/22/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let sharedTaskController = TaskController()
    
    var taskArray: [Task] {
        let moc = Stack.sharedStack.managedObjectContext
        let request = NSFetchRequest(entityName: "Task")
        do {
            return try moc.executeFetchRequest(request) as! [Task]
        } catch {
            print("Error loading: \(error)")
            return []
        }
    }
    
    func addTask(task: Task) {
        save()
    }
    
    func removeTask(indexPath: NSIndexPath) {
        if let moc = taskArray[indexPath.row - 1].managedObjectContext {
            moc.deleteObject(taskArray[indexPath.row - 1])
        }
        save()
    }
    
    func save() {
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            try moc.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
    
}
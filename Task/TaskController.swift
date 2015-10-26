//
//  TaskController.swift
//  Task
//
//  Created by James Pacheco on 10/22/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class TaskController {
    
    static let sharedTaskController = TaskController()
    
    var taskArray: [Task] = []

    init() {
        load()
    }
    
    func addTask(task: Task) {
        taskArray.append(task)
        save()
    }
    
    func removeTask(indexPath: NSIndexPath) {
        taskArray.removeAtIndex(indexPath.row)
        save()
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(taskArray, toFile: Task.ArchiveURL.path!)
    }
    
    func load() {
        if let unarchivedTasks = NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task]{
            self.taskArray = unarchivedTasks
        } else {
            taskArray = []
        }
    }
}
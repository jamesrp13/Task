//
//  Task+CoreDataProperties.swift
//  Task
//
//  Created by James Pacheco on 10/26/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var title: String
    @NSManaged var dueDate: NSDate?
    @NSManaged var notes: String?
    @NSManaged var isComplete: NSNumber
    @NSManaged var dateCreated: NSDate

}



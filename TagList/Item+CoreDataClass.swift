//
//  Item+CoreDataClass.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//
//

import Foundation
import CoreData


public class Item: NSManagedObject, Identifiable {
    @NSManaged public var checked: Bool
    @NSManaged public var dueDate: Date?
    @NSManaged public var tags: String?
    @NSManaged public var id: UUID?
    @NSManaged public var hasDueDate: Bool
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var flagged: Bool
    @NSManaged public var priority: Double
    @NSManaged public var trashed: Bool
    @NSManaged public var createdDate: Date?

}

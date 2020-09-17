//
//  Tag+CoreDataProperties.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/23/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var show: Bool



}

//
//  Item+CoreDataProperties.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    

}

//extension Item {
//    /*
//     ❎ CoreData FetchRequest in ContentView calls this function
//        to get all of the Song entities in the database
//     */
//    
//    static func allItemsFetchRequest() -> NSFetchRequest<Item> {
//       
//        let request: NSFetchRequest<Item> = Item.fetchRequest() as! NSFetchRequest<Item>
//        /*
//         Item the songs in alphabetical order with respect to artistName;
//         If artistName is the same, then sort with respect to songName.
//         */
//        request.sortDescriptors = [
//            // Primary sort key: artistName
//            NSSortDescriptor(key: "name", ascending: true),
//            // Secondary sort key: songName
//        ]
//       
//        return request
//    }
//}

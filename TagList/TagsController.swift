//
//  TagsController.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import Foundation
import SwiftUI

class TagsController: ObservableObject {
    @Published var itemsInClass = [Item]()
    @Published var tagsInClass = [Tag]()
    @Published var itemsForView = [[Item]]()

       
  
    
    
    func getTagItems() {
        itemsForView = [[Item]]()
        for val in 0 ..< tagsInClass.count {
            itemsForView.append([Item]())
            for item in itemsInClass {

                if item.tags!.contains("\(tagsInClass[val].id ?? UUID())")  && !item.checked && !item.trashed{
                    itemsForView[val].append(item)
                }
            }
        }
    }
}

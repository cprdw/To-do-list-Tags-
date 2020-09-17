//
//  UrgencyView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct UrgencyView: View {
    @ObservedObject var urgencyController: UrgencyController
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [])
    
    var allItems: FetchedResults<Item>
    @Binding var colorName: String
    @Environment(\.managedObjectContext) var context

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                PriorityLevelView(title: "Critical",message: "No Critical Items", items: urgencyController.CriticalItems, colorName: self.$colorName, urgencyController: urgencyController).environment(\.managedObjectContext, context)
                PriorityLevelView(title: "High", message: "No High Priority Items", items: urgencyController.HighItems, colorName: self.$colorName, urgencyController: urgencyController).environment(\.managedObjectContext, context)
                PriorityLevelView(title: "Medium", message: "No Medium Priority Items", items: urgencyController.MediumItems, colorName: self.$colorName, urgencyController: urgencyController).environment(\.managedObjectContext, context)
                PriorityLevelView(title: "Low", message: "No Low Priority Items", items: urgencyController.LowItems, colorName: self.$colorName, urgencyController: urgencyController).environment(\.managedObjectContext, context)
                PriorityLevelView(title: "No Urgency", message: "No Other Items", items: urgencyController.OtherItems, colorName: self.$colorName, urgencyController: urgencyController).environment(\.managedObjectContext, context)
                
            }
        }
        .onAppear {
            self.urgencyController.itemsInClass = [Item]()
            for val in self.allItems {
                    self.urgencyController.itemsInClass.append(val)
                
            }
            self.urgencyController.getUrgency()

        }
        
    }
}


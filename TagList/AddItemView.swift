//
//  AddItemView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var context

    
    @State var tagsIncluded = [UUID]()
    @State var name = ""
    @State var notes = ""
    @State var hasDueDate = false
    @State var dueDate = Date().addingTimeInterval(-200)
    @State var isFlagged = false
    @State var priorityLevel = 0
    @State var tags = ""
    var body: some View {
        Form {
            
            Section(header: Text("Name")) {
                TextField("Name of Item", text: self.$name)
            }
            Section(header: Text("Description")) {
                TextField("Notes", text: self.$notes)
            }
            
            Section(header: Text("Due Date")) {
                Toggle(isOn: self.$hasDueDate) {
                    Text("Has a due date")
                }
                
                if hasDueDate {
                    DatePicker(selection: $dueDate, in: Date()..., displayedComponents: .date) {
                        Text("Due Date:")
                    }
                }
            }
            
            
            Section(header: Text("Tags")) {
                
                
                NavigationLink(destination: TagSelectorView(tagsIncluded: self.$tagsIncluded)) {
                    Text("Select Tag")
                }
                
                
                
                NavigationLink(destination: AddTagView().environment(\.managedObjectContext, context)) {
                    Text("Add New Tag")
                }
                
            
            }
            
            
            Section(header: Text("Additional Options")) {
                Toggle(isOn: self.$isFlagged) {
                    HStack {
                        Image(systemName: "flag.fill")
                        Text("Flagged")
                    }
                }
                
                Picker(selection: self.$priorityLevel, label: Text("Urgency"))  {
                    ForEach (0 ..< 5) { val in
                        Text("\(priorities[val])")
                    }
                }
                
            
            }
            
            
            
            
            
            
        }
    .navigationBarTitle("New Item")

        .navigationBarItems(trailing:
            Button(action: {
                // Save the item
                let item = Item(context: self.context)
                item.name = self.name
                item.notes = self.notes
                item.hasDueDate = self.hasDueDate
                item.dueDate = self.dueDate
                item.flagged = self.isFlagged
                item.priority = Double(self.priorityLevel)
                var tags = ""
                for val in self.tagsIncluded {
                    tags.append(" \(val) ")
                }
                item.tags = tags
                item.id = UUID()
                item.trashed = false
                item.createdDate = Date()
                do {
                                       // Try to save the changes
                                       try self.context.save()
                                   } catch {
                                       let nserror = error as NSError
                                       fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                                   }
                
                
                
                if (item.priority == 4.0 && (UserDefaults.standard.string(forKey: "Badge") ?? "").contains("Critical")) || (item.dueDate ?? Date().addingTimeInterval(-1000) <= Date() && (UserDefaults.standard.string(forKey: "Badge") ?? "").contains("Today")){
                    badgeNumber += 1
                    UserDefaults.standard.set(badgeNumber, forKey: "BadgeNumber")

                }
                
                
                
                self.presentationMode.wrappedValue.dismiss()

            }) {
                Text("Save")
            }
        )
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}

let priorities = ["None", "Low", "Medium", "High", "Critical"]

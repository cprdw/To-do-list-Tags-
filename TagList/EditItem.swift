//
//  EditItem.swift
//  TagList
//
//  Created by Chester de Wolfe on 6/1/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct EditItem: View {
        @Environment(\.presentationMode) var presentationMode
        @Environment(\.managedObjectContext) var context
    var item: Item
        
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
                .onAppear{
                    self.name = self.item.name ?? ""
                    self.notes = self.item.notes ?? ""
                    self.hasDueDate = self.item.hasDueDate
                    self.dueDate = self.item.dueDate ?? Date()
                    self.isFlagged = self.item.flagged
                    self.priorityLevel = Int(self.item.priority)
                    self.tags = self.item.tags ?? ""

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
                    self.item.name = self.name
                    self.item.notes = self.notes
                    self.item.hasDueDate = self.hasDueDate
                    self.item.dueDate = self.dueDate
                    self.item.flagged = self.isFlagged
                    self.item.priority = Double(self.priorityLevel)
                    var tags = ""
                    for val in self.tagsIncluded {
                        tags.append(" \(val) ")
                    }
                    self.item.tags = tags
                    do {
                                           // Try to save the changes
                                           try self.context.save()
                                       } catch {
                                           let nserror = error as NSError
                                           fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                                       }
                    
                    self.presentationMode.wrappedValue.dismiss()

                }) {
                    Text("Save")
                }
            )
        }
    }

//struct EditItem_Previews: PreviewProvider {
//    static var previews: some View {
//        EditItem()
//    }
//}

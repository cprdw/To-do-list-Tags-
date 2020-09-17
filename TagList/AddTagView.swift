//
//  AddTagView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/23/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct AddTagView: View {
    @State var name = ""
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode

    @State var color = 1

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name of Tag", text: self.$name)

            }
            
            Picker(selection: self.$color, label:
            Text("Tag Color")
            
            )  {
                ForEach (1 ..< 8) { val in
                    Image(systemName: "tag.fill").foregroundColor(Color("Color\(val)"))
                }
            }
        .navigationBarTitle("New Tag")
            .navigationBarItems(trailing:
            Button(action: {
                // Save the item
                let tag = Tag(context: self.context)
                tag.name = self.name
                tag.color = "Color\(self.color + 1)"
                tag.show = true
                tag.id = UUID()
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
            })
            
            
        }
    }
}

struct AddTagView_Previews: PreviewProvider {
    static var previews: some View {
        AddTagView()
    }
}

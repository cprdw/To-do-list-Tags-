//
//  ItemRow.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct ItemRow: View {
    @Environment(\.managedObjectContext) var context
    var item: Item
        var text = "Homework"
        @State var checked = false
    @State var colorName = UserDefaults.standard.string(forKey: "PrimaryColor")

        var body: some View {
            VStack {
                HStack {
                    Image(systemName: self.checked ? "checkmark" : "square")
                        .foregroundColor(self.checked ? .green : Color("Secondary"))
                        .onTapGesture {
                            self.item.checked.toggle()
                            self.checked.toggle()
                            do {
                                // Try to save the changes
                                try self.context.save()
                            } catch {
                                let nserror = error as NSError
                                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                            }

                    }
                    .padding(.trailing, self.checked ? 1 : 0)
                    .onAppear{
                        self.checked = self.item.checked
                        self.colorName = UserDefaults.standard.string(forKey: "PrimaryColor")
                    }
                    VStack (alignment: .leading) {
                        Text(item.name ?? "")
                            .strikethrough(self.checked)
                            .padding(.leading)
                            .foregroundColor(Color(colorName ?? "Color0"))

                            .font(.headline)
                        
                        if item.hasDueDate {
                            Text(formatDate(date: item.dueDate ?? Date()))
                                .font(.caption)
                                .foregroundColor(Color("Secondary"))
                            .padding(.leading)

                        }
                    }
                    
                    Spacer()
                }
                .padding(.leading)

            }
            .padding(.bottom)


        }
    }

//
//  TagItemsView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/23/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct TagItemsView: View {
    var tag: Tag
    var message: String
    var items: [Item]
    @Binding var colorName: String
    @State var showMenu = false
    @State var sendOff = false
    @Environment(\.managedObjectContext) var context
@ObservedObject var tagsController: TagsController
    @FetchRequest(entity: Tag.entity(),
                  sortDescriptors: [])
    
    var allTags: FetchedResults<Tag>
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "tag.fill")
                .font(.title)
                    .foregroundColor(Color("\(tag.color ?? "")"))
                Text("\(tag.name ?? "")")
                    .bold()
                    .foregroundColor(Color(self.colorName))

                    .font(.title)
                Spacer()
            }
            .padding(.bottom)
            .onTapGesture {
                self.showMenu = true
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            .actionSheet(isPresented: $showMenu, content: { actionSheet })

            
            if items.isEmpty {
                Text(message)
                    .padding()
                .foregroundColor(Color(colorName))


            }
            
            NavigationLink(destination: TimerView(colorName: self.$colorName, itemsIn: self.items),
                           isActive: $sendOff) {
                EmptyView()
            }
            
            ForEach(items) { val in
                NavigationLink(destination: ItemView(item: val)) {
                    ItemRow(item: val)
                }
                Divider()
                    .offset(x: 20, y: -10)

                
            }
            
        }
            .padding(.leading)

        .frame(width: screen.width)
    }
    
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text(self.tag.name ?? ""),
            message: Text("What would you like to do with these items?"),
            buttons: [
                .default(Text("Open in timer")) {
                    self.sendOff = true
                    self.showMenu = false
                },
                .destructive(Text("Remove Tag")) {
                    self.showMenu = false
                    self.context.delete(self.tag)
//                    var count = 0
//                    for val in self.tagsController.tagsInClass {
//                        if val.id ?? UUID() == self.tag.id ?? UUID() {
//                            self.tagsController.tagsInClass.remove(at: count)
//                        }
//                        count += 1
//                    }
                    self.tagsController.tagsInClass = [Tag]()
                    for val in self.allTags {
                        self.tagsController.tagsInClass.append(val)

                    }
                    self.tagsController.getTagItems()

                    do {
                      try self.context.save()
                    } catch {
                        
                    }
                },
                .destructive(Text("Remove All")) {
                    self.showMenu = false
                },
                .cancel() {
                    self.showMenu = false
                }
            ])
    }
}

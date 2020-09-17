//
//  PriorityLevelView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/23/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct PriorityLevelView: View {
    var title: String
    var message: String
    var items: [Item]
    @Binding var colorName: String
    @State var showMenu = false
    @State var sendOff = false
    @State var item = Item()
    @Environment(\.managedObjectContext) var context
    @ObservedObject var urgencyController: UrgencyController
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [])
    
    var allItems: FetchedResults<Item>
    @State var sendItem = false
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .bold()
                    .font(.system(size: 25))
                .foregroundColor(Color(colorName))
                    .onTapGesture {
                        self.showMenu = true
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                }
                .padding(.bottom)


                Spacer()
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
            
            NavigationLink(destination: ItemView(item: self.item), isActive: self.$sendItem) {
                EmptyView()
            }
            
            ForEach(items) { val in
                    ItemRow(item: val)
                        .onTapGesture {
                            self.item = val
                            self.sendItem = true
                    }
                    .onLongPressGesture {
                        self.showMenu = true
                        self.item = val
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
            title: Text(self.title),
            message: Text("What would you like to do with these items?"),
            buttons: [
                .default(Text("Open in timer")) {
                    self.sendOff = true
                    self.showMenu = false
                },
                .destructive(Text("Delete Item(s)")) {
                    self.showMenu = false
                    
                    //self.context.delete(self.item)
                    self.item.trashed = true
                    self.item.createdDate = Date()
                    self.urgencyController.itemsInClass = [Item]()
                    for val in self.allItems {
                            self.urgencyController.itemsInClass.append(val)
                        
                    }
                    self.urgencyController.getUrgency()
//                    do {
//                        try self.context.save()
//                    } catch {
//
//                    }
                },
                .cancel() {
                    self.showMenu = false
                }
        ])
    }
}

//struct PriorityLevelView_Previews: PreviewProvider {
//    static var previews: some View {
//        PriorityLevelView()
//    }
//}

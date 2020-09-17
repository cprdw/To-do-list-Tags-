//
//  TagsView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct TagsView: View {
    @Environment(\.managedObjectContext) var context

    @ObservedObject var tagsController: TagsController
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [])
    
    var allItems: FetchedResults<Item>
    
    @FetchRequest(entity: Tag.entity(),
                  sortDescriptors: [])
    
    var allTags: FetchedResults<Tag>
    @State var count = 0
    @Binding var colorName: String

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    ForEach(self.tagsController.tagsInClass) { tag in
                        Button(action: {
                            tag.show.toggle()
                            self.tagsController.getTagItems()
                        }) {
                            VStack {
                                Image(systemName: tag.show ? "tag.circle.fill" : "tag.circle")
                                    .foregroundColor(Color("\(tag.color ?? "")"))
                                    .font(.largeTitle)
                                
                                Text("\(tag.name ?? "")")
                                    .foregroundColor(Color(self.colorName))
                                    .font(.caption)
                            }
                        .padding()
                        
                        }
                    }
                }
            }
            .padding(.bottom)
            .padding(.top, -10)
            if allTags.isEmpty {
                Text("No Tags Yet")
                .foregroundColor(Color(self.colorName))

                NavigationLink(destination: AddTagView()) {
                    Text("Add Tags")
                        .font(.headline)
//                        .frame(height: 60)
//                        .background(Color(.white).opacity(0.001))
//                    .clipShape(Rectangle())
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
                    
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0 ..< allTags.count) { val in
                    if self.tagsController.itemsForView.count > 0  && self.tagsController.tagsInClass[val].show {
                        TagItemsView(tag: self.tagsController.tagsInClass[val], message: "No items for \(self.tagsController.tagsInClass[val].name ?? "") tag", items: self.tagsController.itemsForView[val], colorName: self.$colorName, tagsController: self.tagsController).environment(\.managedObjectContext, self.context)
                    }
                }
                

            }
            .frame(width: screen.width)
        }
            .frame(width: screen.width)

        .onAppear {
            self.tagsController.itemsInClass = [Item]()
            self.tagsController.tagsInClass = [Tag]()

            for val in self.allItems {
                self.tagsController.itemsInClass.append(val)
            }
            
            for val in self.allTags {
                self.tagsController.tagsInClass.append(val)
            }
            
            self.tagsController.getTagItems()
            self.count = self.allTags.count
        }
    }
}



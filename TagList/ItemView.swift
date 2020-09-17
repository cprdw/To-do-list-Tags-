//
//  ItemView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode

    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [])
    
    var allItems: FetchedResults<Item>
    
    @FetchRequest(entity: Tag.entity(),
                  sortDescriptors: [])
    
    var allTags: FetchedResults<Tag>

    var body: some View {
        
        
        VStack {
            
            Text(item.name ?? "")
                .bold()
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Text(" ")
                        .padding()
                    ForEach(self.allTags) { tag in
                        if (self.item.tags?.contains("\(tag.id ?? UUID())")) ?? false {
                            VStack {
                                Image(systemName: "tag.circle.fill")
                                    .foregroundColor(Color("\(tag.color ?? "")"))
                                    .font(.largeTitle)
                                
                                Text("\(tag.name ?? "")")
                                    .foregroundColor(.primary)
                                    .font(.caption)
                            }
                            .padding(.leading)
                            .padding(.vertical)
                        }
                        
                    }
                }
            }
            .navigationBarItems(trailing: NavigationLink(destination: EditItem(item: self.item)){
                Text("Edit")
            })
            
            
            if (item.notes ?? "") != "" {
                Text("Notes: ")
                Text(item.notes ?? "")
            }
            Button(action: {
                //self.context.delete(self.item)
                self.item.trashed = true
                self.item.createdDate = Date()
                self.presentationMode.wrappedValue.dismiss()

                do {
                  try self.context.save()
                } catch {
                    
                }
            }) {
                Image(systemName: "xmark")
                    .frame(width: 50, height: 50)
                    .background(Color(.white))
                .clipShape(Circle())
                    .foregroundColor(.red)
                .shadow(radius: 3)
            }
        } //vstack
    } // end of view
    
    
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
            Text("Example")
                .bold()
                .font(.title)
            
            Text("Notes")
            
            Button(action: {
                //self.context.delete(self.item)
                
                //self.presentationMode.wrappedValue.dismiss()

//                do {
//                  try self.context.save()
//                } catch {
//
//                }
            }) {
                Image(systemName: "xmark")
                    .frame(width: 50, height: 50)
                    .background(Color(.white))
                .clipShape(Circle())
                    .foregroundColor(.red)
                .shadow(radius: 3)
            }
        } //vstack
    }
}

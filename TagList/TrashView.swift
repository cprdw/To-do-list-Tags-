//
//  TrashView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/28/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct TrashView: View {
        @FetchRequest(entity: Item.entity(),
                      sortDescriptors: [])
        
        var allItems: FetchedResults<Item>
        @Binding var colorName: String
        var body: some View {
            VStack {
                HStack {
                    Image(systemName: "trash.fill")
                        .padding(.leading)
                    
                    Text("Trash")
                    Spacer()
                }
                .font(.largeTitle)
            .foregroundColor(Color(colorName))
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(allItems) { item in
                        if item.trashed {
                            NavigationLink (destination: ItemView(item: item)) {
                                ItemRow(item: item)
                                
                            }
                            
                        }
                    }
                }
                Spacer()
            }
        }
    }


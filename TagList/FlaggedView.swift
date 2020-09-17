//
//  FlaggedView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/25/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct FlaggedView: View {
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [])
    
    var allItems: FetchedResults<Item>
    @Binding var colorName: String
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "flag.fill")
                    .padding(.leading)
                
                Text("Flagged")
                Spacer()
            }
            .font(.largeTitle)
        .foregroundColor(Color(colorName))
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(allItems) { item in
                    if item.flagged {
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

//struct FlaggedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlaggedView()
//    }
//}

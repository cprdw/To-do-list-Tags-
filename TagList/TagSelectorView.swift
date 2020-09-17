//
//  TagSelectorView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/23/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct TagSelectorView: View {
    @FetchRequest(entity: Tag.entity(),
                  sortDescriptors: [])
    
    var allTags: FetchedResults<Tag>
    @Binding var tagsIncluded: [UUID]
    var body: some View {
        Form {
            List {
                ForEach (allTags) { val in
                    Button(action: {
                        if self.tagsIncluded.contains(val.id ?? UUID()) {
                            for num in 0 ..< self.tagsIncluded.count {
                                if self.tagsIncluded[num] == val.id {
                                    self.tagsIncluded.remove(at: num)
                                }
                            }
                        }
                        else {
                            self.tagsIncluded.append(val.id ?? UUID())
                        }
                    } ) {
                        HStack {
                            Image(systemName: "tag.fill")
                                .foregroundColor(Color("\(val.color ?? "")"))
                                .padding(.leading)
                            
                            Text("\(val.name ?? "")")
                                .foregroundColor(Color("\(val.color ?? "")"))
                            Spacer()
                            Image(systemName: self.tagsIncluded.contains(val.id ?? UUID()) ? "checkmark" : "")
                        }
                    }
                    
                }
            }
        }
    }
}

//struct TagSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        TagSelectorView()
//    }
//}

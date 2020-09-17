//
//  FilterPickerView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/27/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct FilterPickerView: View {
    @Binding var viewState: Int
    var body: some View {
        Picker(selection: self.$viewState, label: Text(""))  {
            ForEach (1 ..< 8) { val in
                Text("\(options[val])")
            }
        }
        .onDisappear{
            print(self.viewState)

            
        }
    }
}

//struct FilterPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterPickerView()
//    }
//}

let options = ["", "Tags", "Date", "Priority", "Flagged", "Completed", "ABC Ascending", "ABC Descending"]

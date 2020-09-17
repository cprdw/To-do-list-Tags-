//
//  DateView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct DateView: View {
    @ObservedObject var homeController: HomeController
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [])
    
    var allItems: FetchedResults<Item>
    @Binding var colorName: String
    @Environment(\.managedObjectContext) var context

    var body: some View {
        VStack {
            ScrollView (.vertical, showsIndicators: false) {
                TodayView(title: "Today", message: "No items due Today", items: homeController.todayItems, colorName: self.$colorName)
                TodayView(title: "Tomorrow", message: "No items due Tomorrow", items: homeController.tomorrowItems, colorName: self.$colorName)
                TodayView(title: "This Week", message: "No items due this Week", items: homeController.weekItems, colorName: self.$colorName)
                TodayView(title: "This Month", message: "No items due this Month", items: homeController.monthItems, colorName: self.$colorName)
                TodayView(title: "Later", message: "No items due Later", items: homeController.laterItems, colorName: self.$colorName)

                //MonthlyView
                //OthersView
            }
            .onAppear {
                for val in self.allItems {
                    if !(self.homeController.itemsInClass.contains(val)) {
                        self.homeController.itemsInClass.append(val)
                    }
                }
                self.homeController.getImportant()
                self.homeController.getDateItems()
                self.colorName = UserDefaults.standard.string(forKey: "PrimaryColor") ?? "Color0"
                

            }
        } // End of VStack
    }
}

//struct DateView_Previews: PreviewProvider {
//    static var previews: some View {
//        DateView(homeController: HomeController())
//    }
//}

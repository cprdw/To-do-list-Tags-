//
//  WeekView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct WeekView: View {
    @ObservedObject var homeController: HomeController
    @Binding var colorName: String

    var body: some View {
        VStack {
            HStack {
                Text("This Week")
                    .bold()
                    .font(.system(size: 25))
                    .foregroundColor(Color(colorName ))


                Spacer()
            }

            if homeController.weekItems.isEmpty {
                Text("No items due this week")
                    .padding()
                    .foregroundColor(Color(colorName ))


            }
            
            ForEach(homeController.weekItems) { val in
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
}

//struct WeekView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeekView(homeController: HomeController())
//    }
//}

//
//  TomorrowView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct TomorrowView: View {
    @ObservedObject var homeController: HomeController
    @Binding var colorName: String

    var body: some View {
        VStack {
            HStack {
                Text("Tomorrow")
                    .bold()
                    .font(.system(size: 25))
                    .foregroundColor(Color(colorName ))


                Spacer()
            }

            if homeController.tomorrowItems.isEmpty {
                Text("No items due Tomorrow")
                    .padding()
                    .foregroundColor(Color(colorName ))


            }
            
            ForEach(homeController.tomorrowItems) { val in
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
//
//struct TomorrowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TomorrowView(homeController: HomeController())
//    }
//}


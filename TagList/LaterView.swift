//
//  LaterView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct LaterView: View {
    @ObservedObject var homeController: HomeController
    @Binding var colorName: String

    var body: some View {
        VStack {
            
            HStack {
                Text("This Month")
                    .bold()
                    .font(.system(size: 25))
                    .foregroundColor(Color(colorName ))


                Spacer()
            }

            if homeController.monthItems.isEmpty {
                Text("No items due this Month")
                    .padding()
                    .foregroundColor(Color(colorName ))


            }
            
            ForEach(homeController.monthItems) { val in
                NavigationLink(destination: ItemView(item: val)) {
                    ItemRow(item: val)
                }
                
                Divider()
                .offset(x: 20, y: -10)
            }
            
            
            
            
            
            HStack {
                Text("Later")
                    .bold()
                    .font(.system(size: 25))
                    .foregroundColor(Color(colorName ))


                Spacer()
            }

            if homeController.laterItems.isEmpty {
                Text("No items due later")
                    .padding()
                    .foregroundColor(Color(colorName ))


            }
            
            ForEach(homeController.laterItems) { val in
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

//struct LaterView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaterView(homeController: HomeController())
//    }
//}

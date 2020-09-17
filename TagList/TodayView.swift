//
//  TodayView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct TodayView: View {
        var title: String
        var message: String
        var items: [Item]
        @Binding var colorName: String
        @State var showMenu = false
        @State var sendOff = false

        var body: some View {
            VStack {
                HStack {
                    Text(title)
                        .bold()
                        .font(.system(size: 25))
                    .foregroundColor(Color(colorName))
                        .onTapGesture {
                            self.showMenu = true
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.success)
                    }
                    .padding(.bottom)


                    Spacer()
                }
                .actionSheet(isPresented: $showMenu, content: { actionSheet })

                
                if items.isEmpty {
                    Text(message)
                        .padding()
                    .foregroundColor(Color(colorName))


                }
                
                NavigationLink(destination: TimerView(colorName: self.$colorName, itemsIn: self.items),
                               isActive: $sendOff) {
                    EmptyView()
                }
                
                ForEach(items) { val in
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
        
        var actionSheet: ActionSheet {
            ActionSheet(
                title: Text(self.title),
                message: Text("What would you like to do with these items?"),
                buttons: [
                    .default(Text("Open in timer")) {
                        self.sendOff = true
                        self.showMenu = false
                    },
                    .destructive(Text("Remove All")) {
                        self.showMenu = false
                    },
                    .cancel() {
                        self.showMenu = false
                    }
                ])
        }
    }

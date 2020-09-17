//
//  ButtonsView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct ButtonsView: View {
    @Binding var viewState: Int
    @Binding var shiftAmount: CGFloat
    var body: some View {
        HStack {
            Text("Tags")
                .frame(width: screen.width / 3.5, height: 40)
                .background(Color(.systemBackground))
                .clipShape(Rectangle())
            .cornerRadius(10)
            .shadow(radius: 2)
                .onTapGesture {
                    if self.viewState == 1 {
                        self.shiftAmount = screen.width
                    }
                    self.viewState = 0
            }
            .scaleEffect(self.viewState == 0 ? 1 : 0.7)
            .animation(.easeIn)

            
            
            Text("Date")
                .frame(width: screen.width / 3.5, height: 40)
                .background(Color(.systemBackground))
                .clipShape(Rectangle())
            .cornerRadius(10)
            .shadow(radius: 2)
                .onTapGesture {
                    
                    
                    self.viewState = 1
            }
            .scaleEffect(self.viewState == 1 ? 1 : 0.7)
            .animation(.easeIn)


            
            
            Text("Urgency")
                .frame(width: screen.width / 3.5, height: 40)
                .background(Color(.systemBackground))
                .clipShape(Rectangle())
            .cornerRadius(10)
            .shadow(radius: 2)
                .onTapGesture {
                    if self.viewState == 1 {
                        self.shiftAmount = -screen.width
                    }
                    self.viewState = 2
            }
            .scaleEffect(self.viewState == 2 ? 1 : 0.7)
            .animation(.easeIn)

        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

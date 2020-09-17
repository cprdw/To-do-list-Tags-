//
//  PomodoroOption.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/26/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct PomodoroOption: View {
        @Binding var originalTime: Int
        @Binding var timeRemaining: Int
        @Binding var breakTime: Int
        @State var customWork = ""
        @State var customBreak = "5"

    
        @Environment(\.presentationMode) var presentationMode

        
        var body: some View {
            VStack {
                Text("Pomodoro")
                .bold()
                    .font(.title)
                    .padding()
                
                Text(customWork != "" ? "\((Int(customWork) ?? 0)):00" : "\(timeRemaining / 60):\(self.timeRemaining % 60 < 10 ? "0" : "")\(timeRemaining % 60)")
                .bold()
                .font(.system(size: 72))
               
                
                HStack {
                  Image(systemName: "clock").foregroundColor(.gray)
                    TextField("Enter Number of Minutes for Working", text: self.$customWork)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                  }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding()
                
                HStack {
                  Image(systemName: "clock").foregroundColor(.gray)
                    TextField("Enter Number of Minutes for Break", text: self.$customBreak)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                  }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding()
                
                Button(action: {
                    if Int(self.customWork) ?? 0 != 0 {
                        self.originalTime = (Int(self.customWork) ?? 20) * 60
                        self.timeRemaining = (Int(self.customWork) ?? 20) * 60

                    }
                    if Int(self.customBreak) ?? 0 != 0 {
                        self.breakTime = Int(self.customBreak) ?? 0
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()

                }) {
                    Text("Done")
                        .foregroundColor(.primary)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding()

                }
                
                
                

            }
        }
    }

//
//  CountDownOption.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/26/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct CountDownOption: View {
    @Binding var originalTime: Int
    @Binding var timeRemaining: Int
    @State var custom = ""
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack {
            Text("Count Down")
            .bold()
                .font(.title)
                .padding()
            
            Text(custom != "" ? "\((Int(custom) ?? 0)):00" : "\(timeRemaining / 60):\(self.timeRemaining % 60 < 10 ? "0" : "")\(timeRemaining % 60)")
            .bold()
            .font(.system(size: 72))
            HStack {
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(times, id: \.self) { val in
                            Text("\(val)")
                                .font(.system(size: 20))
                                .foregroundColor(val * 60 == self.originalTime ? .white : .black)
                                .frame(width: 45, height: 45)
                                .background(Color(val * 60 == self.originalTime ? .black : .white))
                                .clipShape(Circle())
                                .frame(width: 45, height: 45)
                                .shadow(radius: 2)
                                .onTapGesture {
                                    self.originalTime = val * 60
                                    self.timeRemaining = val * 60
                                    self.custom = ""
                            }
                        }
                    }
                    .frame(height: 50)

                }
                .frame(height: 50)

            }
            .frame(height: 50)
            .padding()
            
            HStack {
              Image(systemName: "clock").foregroundColor(.gray)
                TextField("Enter Number of Minutes", text: self.$custom)
                .textFieldStyle(RoundedBorderTextFieldStyle())
              }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .padding()
            
            Button(action: {
                if self.custom != "" {
                    self.originalTime = (Int(self.custom) ?? 20) * 60
                    self.timeRemaining = (Int(self.custom) ?? 20) * 60

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

//struct CountDownOption_Previews: PreviewProvider {
//    static var previews: some View {
//        CountDownOption()
//    }
//}

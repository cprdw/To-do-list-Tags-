//
//  TimerView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/25/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @State var timeRemaining = 60 * 20
    @State var originalTime = 60 * 20
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRunning = false
    @State var showZero = false
    @State var viewState = 0
    @State var editTime = false
    @State var breakTime = 5 * 60
    @State var pomoState = "Work"
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [])
    
    var allItems: FetchedResults<Item>
    @Binding var colorName: String
    var itemsIn = [Item]()
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.timeRunning = false
                    self.timeRemaining = self.originalTime
                    if self.viewState > 0 {
                        self.viewState -= 1
                    }
                    
                    if self.viewState == 1 {
                        self.originalTime = 0
                        self.timeRemaining = 0
                    }
                    else {
                        self.originalTime = 60 * 20
                        self.timeRemaining = 60 * 20

                    }
                }) {
                    Image(systemName: "chevron.left")
                    .font(.largeTitle)
                }
                Spacer()

                Text("\(names[self.viewState])")
                    .onTapGesture {
                        if self.viewState != 1 {
                            self.editTime.toggle()
                        }
                }
                Spacer()

                Button(action: {
                    self.timeRunning = false
                    self.timeRemaining = self.originalTime
                    
                    if self.viewState < 2 {
                        self.viewState += 1
                    }
                    
                    if self.viewState == 1 {
                        self.originalTime = 0
                        self.timeRemaining = 0
                    }
                    else {
                        self.originalTime = 60 * 20
                        self.timeRemaining = 60 * 20
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .font(.largeTitle)
                }
                Spacer()

            }
            .sheet(isPresented: $editTime) {
                if self.viewState == 0 {
                    CountDownOption(originalTime: self.$originalTime, timeRemaining: self.$timeRemaining)

                }
                if self.viewState == 2 {
                    PomodoroOption(originalTime: self.$originalTime, timeRemaining: self.$timeRemaining, breakTime: self.$breakTime)
                }
                
            }
            
            if self.viewState == 2 {
                Text(pomoState)
                    .font(.title)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    self.timeRunning.toggle()
                }) {
                    Image(systemName: self.timeRunning ? "pause.fill" : "play.fill")
                        .font(.largeTitle)
                }
                Spacer()
                Text("\(timeRemaining / 60):\(self.timeRemaining % 60 < 10 ? "0" : "")\(timeRemaining % 60)")
                    .bold()
                    .font(.system(size: 72))
                    .onReceive(timer) { _ in
                        
                        if self.timeRemaining == 0 && self.viewState == 2 {
                            if self.pomoState == "Work" {
                                self.timeRemaining = self.breakTime * 60
                                self.pomoState = "Break"
                            }
                            else {
                                self.timeRemaining = self.originalTime
                                self.pomoState = "Work"
                            }
                        }
                        
                        if self.timeRemaining > 0 && self.timeRunning && self.viewState != 1 {
                            self.timeRemaining -= 1
                        }
                        
                        if self.viewState == 1 && self.timeRunning  {
                            self.timeRemaining += 1

                        }
                    }
                .onTapGesture {
                    
                
                    if self.viewState != 1 {
                        self.editTime.toggle()
                    }
                }
                .padding()
                Spacer()
                Button(action: {
                    self.timeRemaining = self.originalTime
                    self.timeRunning = false
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.largeTitle)
                }
                Spacer()
            }
                VStack (alignment: .leading){
                    ZStack {
                        Color(.gray)
                            .clipShape(Rectangle())
                            .cornerRadius(10)
                            .frame(width: screen.width * 0.9, height: 30)
                            
                        if self.viewState != 1 {

                        HStack {
                            Color(.blue)
                                .clipShape(Rectangle())
                                .cornerRadius(10)
                                .frame(width: screen.width * 0.9 * CGFloat(Double(timeRemaining) / Double(originalTime)), height: 30)
                            
                            Spacer(minLength: screen.width * 0.9 * (1 - CGFloat(Double(timeRemaining) / Double(originalTime))))
                            
                        }
                        .frame(width: screen.width * 0.9)
                        }
                        
                        
                    }
            }
            if itemsIn.isEmpty {
                VStack {
                    HStack {
                        Image(systemName: "flag.fill")
                            .padding(.leading)
                        
                        Text("Flagged")
                        Spacer()
                    }
                    .font(.largeTitle)
                    .foregroundColor(Color(colorName))
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.allItems) { item in
                            if item.flagged {
                                
                                ItemRow(item: item)
                            }
                        }
                    }
                    Spacer()
                }
            }
            
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(self.itemsIn) { item in
                    ItemRow(item: item)
                }
            }
            
            Spacer()
            
            
            
        } // End of Vstack
    }
    
    
    
}
//
//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerView()
//    }
//}

let times = [5, 10, 15, 20, 25, 30, 45, 60, 90, 120]
let names = ["Count Down", "Count Up", "Pomodoro"]



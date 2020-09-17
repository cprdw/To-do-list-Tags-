//
//  ContentView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var homeController: HomeController
    init() {
        self.homeController = HomeController()
        self.urgencyController = UrgencyController()

        self.tagsController = TagsController()
        tagsController.getTagItems()

    }
    @ObservedObject var urgencyController: UrgencyController
    
    @ObservedObject var tagsController: TagsController
        
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Item.entity(),
                    sortDescriptors: [])
      
      var allItems: FetchedResults<Item>
    
    @State var viewState = 1
    @State var shiftAmount = -screen.width
    @State var showMenu = false
    @State var state = "Date"
    @State var showPicker = false
    @State var colorName = UserDefaults.standard.string(forKey: "PrimaryColor") ?? "Color0"
    var body: some View {
        NavigationView {
            ZStack {

                VStack {
                    HStack {
                    Image(systemName: "text.badge.checkmark")
                        .font(.largeTitle)
                        .foregroundColor(Color(colorName))

                    Text("My Tasks")
                    .bold()
                        .font(.largeTitle)
                        .foregroundColor(Color(colorName))

                    }


                    HStack {
                        Spacer()
                        VStack (alignment: .leading){
                            Text(homeController.dateString[1])
                            .bold()
                                .font(.title)
                            .foregroundColor(Color(colorName))


                                Text("  \(homeController.dateString[0])")
                            .bold()
                                    .font(.system(size: 20))
                            .foregroundColor(Color(colorName))


                            //.padding()
                        //.font(.system(size: 20))
                        }


                        Spacer()
                        Spacer()
                        Spacer()


                        Button(action: {
                            self.showPicker.toggle()
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.success)
                        }) {
                            HStack {
                                Text("Sort")
                                .bold()
                                .font(.system(size: 16))
                                    .foregroundColor(Color(colorName ))



                                Image(systemName: "arrowtriangle.down")
                                .font(.system(size: 15))
                                    .foregroundColor(Color(colorName ))


                            }
                                .padding(10)
                            .background(Color(.systemBackground))
                            .clipShape(Rectangle())
                        .cornerRadius(10)
                            .shadow(radius: 2)

                        }
                    .padding()

//                        .sheet(isPresented: self.$showPicker) {
//                            FilterPickerView(viewState: self.$viewState)
//                                .background(Color(.systemBackground).opacity(0.4))
//                        }

                        Spacer()
                    }

//                    ButtonsView(viewState: $viewState, shiftAmount: $shiftAmount)
//                       // .padding(.top, 100)
//                    .padding(.top)
                    if viewState == 0 {
                        TagsView(tagsController: tagsController, colorName: self.$colorName)
                            .environment(\.managedObjectContext, context)
                            .offset(x: viewState == 0 ? 0 : -screen.width)

                            .animation(.default)
                    }

                    if viewState == 1 {

                        DateView(homeController: homeController, colorName: self.$colorName)
                            .environment(\.managedObjectContext, context)
                        .offset(x: viewState == 1 ? 0 : shiftAmount)

                        .animation(.default)
                    }

                        if viewState == 2 {

                        UrgencyView(urgencyController: urgencyController, colorName: self.$colorName)
                            .environment(\.managedObjectContext, context)
                        .offset(x: viewState == 2 ? 0 : screen.width)

                            .animation(.default)

                    }
                    if viewState == 3 {
                        FlaggedView(colorName: self.$colorName)
                            .padding(.horizontal)
                            .padding(.horizontal)

                    }
                    if viewState == 4 {
                        CheckedView(colorName: self.$colorName)
                            .padding(.horizontal)
                            .padding(.horizontal)

                    }

                    Spacer()

                } //End of VStack
                    .background(Color(.white).opacity(0.001))
                    .onTapGesture {
                        self.showMenu = false
                }
                .blur(radius: showMenu  || showPicker ? 6 : 0)
                    .animation(.default)
                .padding(.top, -50)

                if showMenu || showPicker {
                    Rectangle()
                        .frame(width: screen.width, height: screen.height)
                        .foregroundColor(Color(.systemBackground).opacity(0.001))
                        .onTapGesture {
                            self.showMenu = false
                            self.showPicker = false
                    }
                }



                VStack {
                    HStack {

                        Button(action: { self.showMenu.toggle()} ) {
                            VStack {
                            Circle()
                                .shadow(radius: 2)
                                .foregroundColor(Color(.systemBackground))
                                .frame(width: 45, height: 45)
                                .overlay (
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 24))
                                        .foregroundColor(Color(colorName ))

                                        .rotationEffect(Angle(degrees: self.showMenu ? 180 : 0))
                                        .animation(.spring())
                            )
                             Text(" ")
                                .font(.caption)
                                .foregroundColor(.primary)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.leading)
                        .offset(x:  self.showMenu ? 0 : screen.width / 1.3)
                        .animation(.default)



                        NavigationLink (destination: TrashView(colorName: self.$colorName)){
                            VStack {
                                Circle()
                                    .shadow(radius: 2)
                                    .foregroundColor(Color(.systemBackground))
                                    .frame(width: 45, height: 45)
                                    .overlay (
                                        Image(systemName: "trash")
                                            .font(.system(size: 24))
                                            .foregroundColor(Color(colorName ))

                                )
                                Text("Trash")
                                .font(.caption)
                                    .foregroundColor(Color(colorName ))

                            }
                        }
                            .padding(.horizontal)

                        .offset(x:  self.showMenu ? 0 : screen.width / 1.3)
                        .animation(.default)



                        NavigationLink (destination: StatisticsView()){
                            VStack {
                                Circle()
                                    .shadow(radius: 2)
                                    .foregroundColor(Color(.systemBackground))
                                    .frame(width: 45, height: 45)
                                    .overlay (
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(Color(colorName ))

                                )
                                Text("Stats")
                                .font(.caption)
                                    .foregroundColor(Color(colorName ))

                            }
                        }
                            .padding(.horizontal)

                        .offset(x:  self.showMenu ? 0 : screen.width / 1.3)
                        .animation(.default)

                        NavigationLink (destination: TimerView(colorName: self.$colorName)){
                            VStack {
                                Circle()
                                    .shadow(radius: 2)
                                    .foregroundColor(Color(.systemBackground))
                                    .frame(width: 45, height: 45)
                                    .overlay (
                                        Image(systemName: "clock")
                                            .font(.system(size: 24))
                                            .foregroundColor(Color(colorName ))

                                )
                                Text("Timer")
                                    .font(.caption)
                                    .foregroundColor(Color(colorName ))

                            }
                        }
                            .padding(.horizontal)

                        .offset(x:  self.showMenu ? 0 : screen.width / 1.3)
                        .animation(.default)



                        NavigationLink(destination: SettingsView(colorName: self.$colorName)) {
                            VStack {
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 20))
                                .foregroundColor(Color(colorName ))

                                .frame(width: 45, height: 45)
                                .background(Color(.systemBackground))
                                .clipShape(Circle())
                                .frame(width: 45, height: 45)
                                .shadow(radius: 2)

                                Text("Options")
                                    .font(.caption)
                                    .foregroundColor(Color(colorName ))

                            }


                        }
                            .padding(.horizontal)

                        .offset(x:  self.showMenu ? 0 : screen.width / 1.3)
                        .animation(.default)
                        .padding(.trailing, 7)
                        .padding(.trailing, self.showMenu ? 30 : 0)



                    }
                    .offset(y: 10)





                    NavigationLink (destination: AddItemView().environment(\.managedObjectContext, context)){
                        Circle()
                            .shadow(radius: 2)
                            .foregroundColor(Color(.systemBackground))
                            .frame(width: 45, height: 45)
                            .overlay (
                                Image(systemName: "plus")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(colorName ))

                        )
                    }
                    .offset(x: screen.width / 2.6, y: -20)
                    .offset(y: self.showMenu ? screen.width / 4 : 0)
                    .animation(.easeOut)
                    .padding()
                    .padding(.trailing)
                    .offset(y: -5)


                    //.offset(x: self.showMenu ? screen.width / 2 : 0)
                    //.animation(.default)


                }
                .offset(y: CGFloat((screen.height / 2) - 120))
                .padding(.bottom)
                .padding(.leading)


                if self.showPicker {
                FilterPickerView(viewState: self.$viewState)
                    .background(Color(.systemBackground).opacity(0.5))
                }
            } // End of ZStack
            //.edgesIgnoringSafeArea(.all)
            
            
          
        }
    }
       

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



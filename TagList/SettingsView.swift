//
//  SettingsView.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Binding var colorName: String
    var body: some View {
        Form {
            
            Section(header: Text("Name")) {
                Text("Name of Item")
            }
            
            Section(header: Text("Color Settings")) {
                NavigationLink(destination:
                    colorPick(colorName: self.$colorName)
                ) {
                    Text("Pick Primary Color")
                }
            }
            
        } // End of Form
        .navigationBarTitle("Settings")
            
    }
}



struct colorPick: View {
    @Binding var colorName: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            ForEach (0 ..< 8) { val in
                Color("Color\(val)")
                    .onTapGesture {
                        UserDefaults.standard.set("Color\(val)", forKey: "PrimaryColor")
                        self.colorName = "Color\(val)"
                        self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

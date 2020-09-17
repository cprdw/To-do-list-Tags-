//
//  HomeController.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import Foundation
import SwiftUI

class HomeController: ObservableObject {

    @Published var itemsInClass = [Item]()
    
    @Published var importantItems = [Item]()
    @Published var todayItems = [Item]()
    @Published var tomorrowItems = [Item]()
    @Published var weekItems = [Item]()
    @Published var monthItems = [Item]()
    @Published var laterItems = [Item]()





    
    @Published var hasUrgent = false
//    init() {
//        self.getImportant()
//    }

    @Published var dateString = formatDate(date: Date()).components(separatedBy: ",")
    
    func getDateItems() {
        todayItems = [Item]()
        tomorrowItems = [Item]()
        weekItems = [Item]()
        monthItems = [Item]()
        laterItems = [Item]()
        
        
        for val in itemsInClass {
            
            if val.hasDueDate && !val.checked && !val.trashed{
                if val.dueDate! <= Date() || formatDate(date: val.dueDate!) == formatDate(date: Date()){
                    if !todayItems.contains(val) {
                        self.todayItems.append(val)
                    }

                }
            }
            
            if val.hasDueDate && !val.checked && !val.trashed{
                if val.dueDate! <= Date().advanced(by: 90000) || formatDate(date: val.dueDate!) == formatDate(date: Date().advanced(by: 90000)){
                    if !todayItems.contains(val) && !tomorrowItems.contains(val){
                        self.tomorrowItems.append(val)
                    }

                }
            
            }
            
            
            if val.hasDueDate && !val.checked  && !val.trashed{
                if val.dueDate! <= Date().advanced(by: 630000) || formatDate(date: val.dueDate!) == formatDate(date: Date().advanced(by: 630000)){
                    if !todayItems.contains(val) && !tomorrowItems.contains(val) && !weekItems.contains(val){
                        self.weekItems.append(val)
                    }

                }
            
            }
            
            if val.hasDueDate && !val.checked  && !val.trashed{
                if val.dueDate! <= Date().advanced(by: 2700000) || formatDate(date: val.dueDate!) == formatDate(date: Date().advanced(by: 2700000)){
                    if !todayItems.contains(val) && !tomorrowItems.contains(val) && !weekItems.contains(val) && !monthItems.contains(val){
                        self.monthItems.append(val)
                    }

                }
            
            }
            
            if val.hasDueDate && !val.checked && !val.trashed {
                
                if !todayItems.contains(val) && !tomorrowItems.contains(val) && !weekItems.contains(val) && !monthItems.contains(val) && !laterItems.contains(val){
                        self.laterItems.append(val)
                    }

                
            
            }
            
        }
        
        
        
        
    }
    
    
    
    func getImportant() {
//        for val in itemsInClass {
//            print(val.name ?? "test")
//            if val.hasDueDate && !val.checked {
//                if val.dueDate! <= Date() || formatDate(date: val.dueDate!) == formatDate(date: Date()){
//                    if !importantItems.contains(val) {
//                    self.todayItems.append(val)
//                    }
//
//                }
//            }
//        }
        hasUrgent = importantItems.count > 0
        
    }
    
    func showUrgent() -> Bool {
        getImportant()
        return hasUrgent
    }

}

func formatDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
     
    // Select one of the following date styles
//    dateFormatter.dateStyle = .none     // Exclude date
//    dateFormatter.dateStyle = .short    // 11/7/19
//    dateFormatter.dateStyle = .medium   // Nov 7, 2019
//    dateFormatter.dateStyle = .long     // November 7, 2019
    dateFormatter.dateStyle = .full     // Thursday, November 7, 2019
     
    // Select one of the following time styles
    dateFormatter.timeStyle = .none     // Exclude time
//    dateFormatter.timeStyle = .short    // , 5:19 PM
//    dateFormatter.timeStyle = .medium   // at 5:22:41 PM
//    dateFormatter.timeStyle = .long     // at 5:23:56 PM EST
//    dateFormatter.timeStyle = .full     // at 5:25:12 PM Eastern Standard Time
     
    // Set locale to U.S. English Locale (en_US)
    dateFormatter.locale = Locale(identifier: "en_US")
     
    // Obtain date and time as a String according to the dateStyle and timeStyle selected above
    return String(dateFormatter.string(from: date).dropLast(6))
}


let screen = UIScreen.main.bounds



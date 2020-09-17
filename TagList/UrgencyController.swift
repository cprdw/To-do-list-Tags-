//
//  UrgencyController.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/22/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import Foundation
import SwiftUI

class UrgencyController: ObservableObject {

    @Published var itemsInClass = [Item]()
    
    @Published var CriticalItems = [Item]()
    @Published var HighItems = [Item]()
    @Published var MediumItems = [Item]()
    @Published var LowItems = [Item]()
    @Published var OtherItems = [Item]()
    
    func getUrgency() {
        CriticalItems = [Item]()
        HighItems = [Item]()
        MediumItems = [Item]()
        LowItems = [Item]()
        OtherItems = [Item]()
        
        for val in itemsInClass {
            if val.priority == 0.0 && !val.checked && !val.trashed {
                OtherItems.append(val)
            }
            if val.priority == 1.0 && !val.checked && !val.trashed {
                LowItems.append(val)
            }
            if val.priority == 2.0 && !val.checked && !val.trashed {
                MediumItems.append(val)
            }
            if val.priority == 3.0 && !val.checked && !val.trashed {
                HighItems.append(val)
            }
            if val.priority == 4.0 && !val.checked && !val.trashed {
                CriticalItems.append(val)
            }
        }
    }
    
}

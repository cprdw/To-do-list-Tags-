//
//  TimerOptions.swift
//  TagList
//
//  Created by Chester de Wolfe on 5/26/20.
//  Copyright © 2020 Chester de Wolfe. All rights reserved.
//

import SwiftUI

struct TimerOptions: View {
    @Binding var originalTime: Int
    @Binding var timeRemaining: Int
    @Binding var viewState: Int
    
    
    var body: some View {
        VStack {
            if viewState == 1 {
                CountDownOption(originalTime: self.$originalTime, timeRemaining: self.$timeRemaining)
            }
            else {
                CountDownOption(originalTime: self.$originalTime, timeRemaining: self.$timeRemaining)
            }
        }
    }
}

//struct TimerOptions_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerOptions()
//    }
//}

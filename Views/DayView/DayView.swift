//
//  DayView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI

struct DayView: View {
    
    var dc: DataController
    
    var body: some View {
        
        let sessions = dc.sessions
        VStack {
            ForEach(sessions) { session in
                Text("HEY")
            }
            Text("Day View2")
        }
        
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dc: DataController())
    }
}

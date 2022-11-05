//
//  AllEventsView.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct AllEventsView: View {
    
    @ObservedObject var dc: DataController
    
    var body: some View {
        
        var events = dc.events
        
        NavigationStack {
            List {
                ForEach(events) { event in
                    EventRowView(dc: dc, raceEvent: event)
                }
                
            }.navigationTitle("Events")
        }
        
    }
}

struct AllEventsView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventsView(dc: DataController())
    }
}

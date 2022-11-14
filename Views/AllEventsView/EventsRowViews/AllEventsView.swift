//
//  AllEventsView.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct AllEventsView: View {
    
    @ObservedObject var dc: DataController
    @State var navStack = NavigationPath()
    
    var body: some View {
        
        let events = dc.events
        
        NavigationStack(path: $navStack) {
            List(events) { event in
                NavigationLink(value: event){
                    EventRowView(dc: dc, raceEvent: event)
                }
            }.navigationDestination(for: RaceEvent.self) { event in
                EventView(dc: dc, raceEvent: event)
            }
            .navigationTitle("Events")
        }
    }
}

struct AllEventsView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventsView(dc: DataController())
    }
}

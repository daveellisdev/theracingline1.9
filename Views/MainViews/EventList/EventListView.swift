//
//  EventListView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct EventListView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State var navStack = NavigationPath()
    @State private var showingFilterSheet = false
    
    var body: some View {
        
        let events = dc.eventsInProgressAndUpcoming
        
        NavigationStack(path: $navStack) {
            List(events) { event in
                NavigationLink(value: event){
                    EventRowView(dc: dc, sm: sm, raceEvent: event)
                }
            }.navigationDestination(for: RaceEvent.self) { event in
                EventView(dc: dc, sm: sm, event: event)
            }
            .navigationTitle("Events")
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(dc: DataController(), sm: StoreManager())
    }
}

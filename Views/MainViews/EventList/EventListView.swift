//
//  EventListView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct EventListView: View {
    
    @ObservedObject var dc: DataController
    @State var navStack = NavigationPath()
    @State private var showingFilterSheet = false
    
    var body: some View {
        
        let events = dc.eventsInProgressAndUpcoming
        
        NavigationStack(path: $navStack) {
            List(events) { event in
                if event.shouldBeVisible(seriesSettings: dc.seriesSavedSettings) {
                    NavigationLink(value: event){
                        EventRowView(dc: dc, raceEvent: event)
                    }
                }
            }.navigationDestination(for: RaceEvent.self) { event in
                EventView(dc: dc, event: event)
            }
            .navigationTitle("Events")
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(dc: DataController())
    }
}

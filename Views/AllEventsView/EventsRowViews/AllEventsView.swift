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
    @State private var showingFilterSheet = false
    
    var body: some View {
        
        let events = dc.eventsInProgressAndUpcoming
        NavigationStack(path: $navStack) {
//            if !dc.storeManager.subscribed {
//                Button {
//                    showingFilterSheet = true
//                } label: {
//                    GroupBox {
//                        PremiumBarSlim().padding(.horizontal)
//                    }
//                }.sheet(isPresented: $showingFilterSheet){
//                    SubscriptionView(dc: dc)
//                }
//            }
            List(events) { event in
                if event.shouldBeVisible(seriesSettings: dc.seriesSavedSettings) {
                    NavigationLink(value: event){
                        EventRowView(dc: dc, raceEvent: event)
                    }
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

//
//  DayListView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct DayListView: View {
    
    @ObservedObject var dc: DataController
    @State var navStack = NavigationPath()
    
    var body: some View {
        
        let sessions = dc.sessionsInProgressAndUpcoming

        NavigationStack(path: $navStack) {
            List(sessions) { session in
                let durationText = session.getDurationText()
                let series = dc.getSeriesById(seriesId: session.seriesId)
                
                if series != nil {
                    NavigationLink(value: session) {
                        SessionView(dc: dc, series: series!, session: session, durationText: durationText)
                    }
                } // if series is not nil
            }.navigationDestination(for: Session.self) { session in
                SessionDetailsView(dc: dc, session: session)
            }
            .navigationTitle("Sessions")
        }
    }
}

struct DayListView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(dc: DataController())
    }
}

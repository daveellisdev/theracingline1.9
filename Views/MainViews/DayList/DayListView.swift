//
//  DayListView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct DayListView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State var navStack = NavigationPath()
    
    var body: some View {
        
        let sessions = dc.sessionsInProgressAndUpcoming

        NavigationStack(path: $navStack) {
            List(sessions) { session in
                let series = dc.getSeriesById(seriesId: session.seriesId)
                                            
                if series != nil {
                    NavigationLink(value: session) {
                        SessionView(dc: dc, sm: sm, series: series!, session: session)
                    }
                } // if series is not nil
            }.navigationDestination(for: Session.self) { session in
                SessionDetailsView(dc: dc, sm: sm, session: session)
            }
            .navigationTitle("Sessions")
        }
    }
}

struct DayListView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(dc: DataController(), sm: StoreManager())
    }
}

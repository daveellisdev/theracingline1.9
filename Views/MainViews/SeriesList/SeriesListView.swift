//
//  SeriesListView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct SeriesListView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State var navStack = NavigationPath()
    
    var body: some View {
        let seriesList = dc.series
        
        NavigationStack(path: $navStack) {
            List(seriesList) { series in
                
                let events: [RaceEvent] = dc.getEventsBySeriesId(seriesId: series.seriesInfo.id)
                let liveEvents = events.filter {$0.sessionInProgress() != nil && $0.sessionInProgress()!}
                                
                NavigationLink(value: series) {
                    SeriesListViewSeriesName(dc: dc, sm: sm, series: series, hasLiveSession: liveEvents.count > 0 ? true : false)
                }
            }.navigationDestination(for: Series.self) { series in
                SeriesListViewEventList(dc: dc, sm: sm, navStack: $navStack, series: series)
            }.navigationTitle("Series")
        }
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListView(dc: DataController(), sm: StoreManager())
    }
}

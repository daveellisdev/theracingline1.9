//
//  SeriesViewEventList.swift
//  theracingline
//
//  Created by Dave on 29/12/2022.
//

import SwiftUI

struct SeriesListViewEventList: View {
    
    @ObservedObject var dc: DataController
    @Binding var navStack: NavigationPath
    
    let series: Series

    var body: some View {
        
        let events: [RaceEvent] = dc.getEventsBySeriesId(seriesId: series.seriesInfo.id)
        List(events) { event in
            NavigationLink(value: event) {
                EventRowView(dc: dc, raceEvent: event)
            }
        }.navigationDestination(for: RaceEvent.self) { event in
            EventView(dc: dc, event: event)
        }.navigationTitle(series.seriesInfo.name)
    }
}
//
//struct SeriesViewEventList_Previews: PreviewProvider {
//
//    @State var navStack = NavigationPath()
//    static var previews: some View {
//        SeriesListViewEventList(dc: DataController(), navStack: NavigationPath(), series: exampleSeries)
//    }
//}

//
//  SeriesViewEventList.swift
//  theracingline
//
//  Created by Dave on 29/12/2022.
//

import SwiftUI

struct SeriesViewEventList: View {
    
    @ObservedObject var dc: DataController
    @Binding var navStack: NavigationPath
    
    let series: Series

    var body: some View {
        
        let events: [RaceEvent] = dc.getEventsBySeriesId(seriesId: series.seriesInfo.id)
        List(events) { event in
            NavigationLink(value: event) {
                SeriesViewEventListRow(dc: dc, series: series, event: event)
            }
        }.navigationDestination(for: RaceEvent.self) { event in
            SeriesViewEventView(dc: dc, event: event, seriesId: series.seriesInfo.id)
        }.navigationTitle(series.seriesInfo.name)
    }
}

//struct SeriesViewEventList_Previews: PreviewProvider {
//
//    @State var navStack = NavigationPath()
//    static var previews: some View {
//        SeriesViewEventList(dc: DataController(), navStack: navStack, series: exampleSeries)
//    }
//}

//
//  SeriesViewEventView.swift
//  theracingline
//
//  Created by Dave on 29/12/2022.
//

import SwiftUI

struct SeriesViewEventView: View {
    
    @ObservedObject var dc: DataController

    let event: RaceEvent
    let seriesId: String
    
    var body: some View {
        List {
            VStack{
                EventViewCircuitInfo(raceEvent: event)
                GroupBox {
                    HStack {
                        Text("Sessions")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    } //hstack
                    
                    ForEach(event.sessionsSortedByDate()) { session in
                        if session.seriesId == seriesId {
                            if session.isComplete() {
                                // if session has passed
                                EventViewSessionRowExpired(dc: dc, session: session)
                            } else if session.isInProgress() {
                                // if in progress
                                EventViewSessionRowLive(dc: dc, session: session)
                            } else {
                                // if not happened
                                EventViewSessionRow(dc: dc, session: session)
                            } // row selector
                        } // series id check
                    } // foreach
                } // sessions groupbox
                GroupBox {
                    VStack {
                        HStack {
                            Text("Other Series in this event")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        } //hstack
                        HStack {
                            ForEach(event.seriesIds, id: \.self) { sessionsSeriesId in
                                if sessionsSeriesId != seriesId {
                                    let series = dc.getSeriesById(seriesId: sessionsSeriesId)
                                    if series != nil {
                                        EventRowSeriesName(series: series!, shortName: true)
                                    } // if series not nil
                                } // if correct series
                            } // foreach
                            
                            Spacer()
                        }
                        
                    } // vstack
                } // other series groupbox
                
                VStack {
                    EventViewLinks(dc: dc, raceEvent: event, singleSeries: seriesId)
                } // vstack
                GroupBox {
                    Text("Circuit Map")
                }
                GroupBox {
                    Text("Previous and next race buttons")
                }
            }
        }.navigationTitle(event.eventName)
        
        
    }
}

struct SeriesViewEventView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesViewEventView(dc: DataController(), event: exampleEvent, seriesId: "f1")
    }
}

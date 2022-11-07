//
//  EventView.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct EventView: View {
    
    let dc: DataController
    let raceEvent: RaceEvent
    
    var body: some View {
        
        ScrollView {
            GroupBox {
                EventViewCircuitInfo(raceEvent: raceEvent)
                EventRowSeriesRow(dc: dc, raceEvent: raceEvent)
            }
            
            GroupBox {
                HStack {
                    Text("Sessions")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }
                ForEach(raceEvent.sessionsSortedByDate()) { session in
                    
                    EventViewSessionRow(dc: dc, session: session)
                    
                    
                } // foreach
            } // groupbox
            
            GroupBox {
                HStack {
                    Text("Streaming Links")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    
                } // hstack
                EventViewLinks(dc: dc, raceEvent: raceEvent)
                
            } // groupbox
        } // scrollview
        .scrollIndicators(.hidden)
        .navigationTitle(raceEvent.eventName)
        .padding()
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(dc: DataController(), raceEvent: exampleEvent)
    }
}



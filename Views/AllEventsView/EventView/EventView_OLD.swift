//
//  EventView.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct EventView_OLD: View {
    
    let dc: DataController
    let raceEvent: RaceEvent
    
    var body: some View {
        
        let circuitName: String = raceEvent.sessions[0].circuit.circuit
        let circuitLayout: String? = raceEvent.sessions[0].circuit.circuitLayout
        let circuitInfo = dc.getCircuitByName(circuit: circuitName)
        
        ScrollView {
            GroupBox {
                EventViewCircuitInfo(raceEvent: raceEvent)
                EventRowSeriesList(dc: dc, raceEvent: raceEvent)
            } // groupbox
            
            GroupBox {
                HStack {
                    Text("Sessions")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                } //hstack
                
                ForEach(raceEvent.sessionsSortedByDate()) { session in
                    if session.isComplete() || (session.isInProgress() && dc.storeManager.subscribed) {
                        // if session has passed
                        EventViewSessionRowExpired(dc: dc, session: session)
                    } else if session.isInProgress() {
                        // if in progress
                        EventViewSessionRowLive(dc: dc, session: session)
                    } else {
                        // if not happened
                        EventViewSessionRow(dc: dc, session: session)
                    }

                } // foreach
            } // groupbox
            
            EventViewLinks(dc: dc, raceEvent: raceEvent)
            if circuitInfo != nil {
                EventViewCircuitMap(circuit: circuitInfo!, circuitLayout: circuitLayout)
            } // if
        } // scrollview
        .scrollIndicators(.hidden)
        .navigationTitle(raceEvent.eventName)
        .padding(.horizontal)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView_OLD(dc: DataController(), raceEvent: exampleEvent)
    }
}



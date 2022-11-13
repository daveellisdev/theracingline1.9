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
        
        let circuitInfo = dc.getCircuitByName(circuit: raceEvent.sessions[0].circuit.circuit)
        
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
                    if (session.sessionComplete != nil && session.sessionComplete!) {
                        // if session has passed
                        EventViewSessionRowExpired(dc: dc, session: session)
                    } else if session.sessionInProgress != nil && session.sessionInProgress! {
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
                EventViewCircuitMap(circuit: circuitInfo!)
            }
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



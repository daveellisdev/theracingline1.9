//
//  SeriesViewEventView.swift
//  theracingline
//
//  Created by Dave on 29/12/2022.
//

import SwiftUI

struct SeriesViewEventView: View {
    
    let event: RaceEvent
    
    var body: some View {
        List {
            VStack{
                EventViewCircuitInfo(raceEvent: event)
                GroupBox {
                    Text("Session Info")
                }
                GroupBox {
                    Text("Other Series in this event")
                }
                GroupBox {
                    Text("Official Links")
                }
                GroupBox {
                    Text("Streaming Links")
                }
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
        SeriesViewEventView(event: exampleEvent)
    }
}

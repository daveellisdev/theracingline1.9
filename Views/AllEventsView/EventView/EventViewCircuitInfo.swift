//
//  EventViewCircuitInfo.swift
//  theracingline
//
//  Created by Dave on 06/11/2022.
//

import SwiftUI

struct EventViewCircuitInfo: View {
    
    let raceEvent: RaceEvent
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let firstSession: Session = raceEvent.sessions[0] {
                    Text(firstSession.circuit.circuit)
                        .font(.title3)
                        .fontWeight(.bold)
                    if let layout: String = firstSession.circuit.circuitLayout {
                        Text("Layout: \(layout)")
                            .fontWeight(.bold)
                    } // if layout
                } // if first session
            } // vstack
            Spacer()
        } // hstack
    }
}

struct EventViewTitle_Previews: PreviewProvider {
    static var previews: some View {
        EventViewCircuitInfo(raceEvent: exampleEvent)
    }
}

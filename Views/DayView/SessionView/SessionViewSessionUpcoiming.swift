//
//  SessionViewSessionUpcoiming.swift
//  theracingline
//
//  Created by Dave on 15/11/2022.
//

import SwiftUI

struct SessionViewSessionUpcoiming: View {
    
    @ObservedObject var dc: DataController
    var session: Session
    var series: Series
    
    var body: some View {
        
        let durationText = session.getDurationText
        
        GroupBox {
            HStack {
                SessionRowSeriesName(series: series, expired: false)
                Spacer()
            } // hstack
            HStack {
                Text(session.session.sessionName)
                Spacer()
                if durationText != nil {
                    Text(durationText!)
                    Image(systemName: "clock.arrow.2.circlepath")
                        .font(.caption2)
                }
            } // hstack
            .font(.caption)
            HStack {
                Text(session.circuit.circuit)
                Spacer()
                if session.circuit.circuitLayout != nil {
                    Text(session.circuit.circuitLayout!)
                }
            }
            .font(.caption)
            HStack {
                Text(session.raceStartTimeAsString())
                    .font(.caption)
                Spacer()
                Text(session.timeFromNow())
                    .font(.caption)
                Image(systemName: "clock")
                    .font(.caption2)
            }
            .font(.caption)
        }
        
    }
}

struct SessionViewSessionUpcoiming_Previews: PreviewProvider {
    static var previews: some View {
        SessionViewSessionUpcoiming(dc: DataController(), session: exampleSession, series: exampleSeries)
    }
}

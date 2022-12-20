//
//  EventRowSessionDates.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct EventRowSessionDates: View {
    
    let raceEvent: RaceEvent
    
    var body: some View {
        
        if raceEvent.firstRaceDateAsString() != nil {
            HStack {
                if raceEvent.firstRaceDateAsString() != raceEvent.lastRaceDateAsString() {
                    Text("Races:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text("\(raceEvent.firstRaceDateAsString()!) - \(raceEvent.lastRaceDateAsString()!)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text("Race:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text("\(raceEvent.firstRaceDateAsString()!)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        } else {
            HStack {
                if raceEvent.firstSessionDateAsString() != raceEvent.lastSessionDateAsString() {
                    Text("Sessions:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text("\(raceEvent.firstSessionDateAsString()) - \(raceEvent.lastSessionDateAsString())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text("Session:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    Text("\(raceEvent.firstSessionDateAsString())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        
        Spacer()
        Text("\(raceEvent.timeFromNow())")
            .font(.caption)
            .foregroundColor(.secondary)
        Image(systemName: "clock")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.secondary)
    }
}

struct EventRowSessionDates_Previews: PreviewProvider {
    static var previews: some View {
        EventRowSessionDates(raceEvent: exampleEvent)
    }
}

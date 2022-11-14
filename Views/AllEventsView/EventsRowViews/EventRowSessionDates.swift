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
        
        if raceEvent.firstRaceDateAsString != nil {
            HStack {
                if raceEvent.firstRaceDateAsString != raceEvent.lastRaceDateAsString {
                    Text("Races:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Text("\(raceEvent.firstRaceDateAsString!) - \(raceEvent.lastRaceDateAsString!)")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    Text("Race:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Text("\(raceEvent.firstRaceDateAsString!)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
            HStack {
                if raceEvent.firstSessionDateAsString != raceEvent.lastSessionDateAsString {
                    Text("Sessions:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Text("\(raceEvent.firstSessionDateAsString) - \(raceEvent.lastSessionDateAsString)")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    Text("Session:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Text("\(raceEvent.firstSessionDateAsString)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        
        Spacer()
        Text("\(raceEvent.timeFromNow())")
            .font(.caption)
            .foregroundColor(.gray)
        Image(systemName: "clock")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.gray)
    }
}

struct EventRowSessionDates_Previews: PreviewProvider {
    static var previews: some View {
        EventRowSessionDates(raceEvent: exampleEvent)
    }
}

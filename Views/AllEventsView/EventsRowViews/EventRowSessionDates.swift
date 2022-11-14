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
        
        if raceEvent.firstRaceDate != nil {
            HStack {
                if raceEvent.firstRaceDate != raceEvent.lastRaceDate {
                    Text("Races:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Text("\(raceEvent.firstRaceDate!) - \(raceEvent.lastRaceDate!)")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    Text("Race:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Text("\(raceEvent.firstRaceDate!)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
        } else if raceEvent.firstSessionDate != nil {
            HStack {
                if raceEvent.firstSessionDate != raceEvent.lastSessionDate {
                    Text("Sessions:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Text("\(raceEvent.firstSessionDate!) - \(raceEvent.lastSessionDate!)")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    Text("Session:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Text("\(raceEvent.firstSessionDate!)")
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

//
//  EventRowSessionDates.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct EventRowSessionDates: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    let raceEvent: RaceEvent
    
    var body: some View {
        
        if raceEvent.firstRaceDateAsString() != nil {
            HStack {
                if raceEvent.firstRaceDateAsString() != raceEvent.lastRaceDateAsString() {
                    Text("Races:")
                    Image(systemName: "calendar").padding(.trailing, -4)
                    Text("\(raceEvent.firstRaceDateAsString()!) - \(raceEvent.lastRaceDateAsString()!)")
                } else {
                    Text("Race:")
                    Image(systemName: "calendar").padding(.trailing, -4)
                    Text("\(raceEvent.firstRaceDateAsString()!)")
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
        } else {
            HStack {
                if raceEvent.firstSessionDateAsString() != raceEvent.lastSessionDateAsString() {
                    Text("Sessions:")
                    Image(systemName: "calendar").padding(.trailing, -4)
                    Text("\(raceEvent.firstSessionDateAsString()) - \(raceEvent.lastSessionDateAsString())")
                } else {
                    Text("Session:")
                    Image(systemName: "calendar").padding(.trailing, -4)
                    Text("\(raceEvent.firstSessionDateAsString())")
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        
        Spacer()
        if sm.subscribed {
            HStack {
                Text("\(raceEvent.firstSessionTimeFromNow())")
                Image(systemName: "clock")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
        }
           
    }
}

struct EventRowSessionDates_Previews: PreviewProvider {
    static var previews: some View {
        EventRowSessionDates(dc: DataController(), sm: StoreManager(), raceEvent: exampleEvent)
    }
    
}

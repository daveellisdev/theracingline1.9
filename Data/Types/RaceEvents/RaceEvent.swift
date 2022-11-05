//
//  RaceEvent.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation
import SwiftDate

struct RaceEvent: Codable, Identifiable {
    let id = UUID()
    let eventId: Int
    let eventName: String
    let seriesIds: [String]
    let sessions: [Session]
    
    var firstRaceDate: String? {
        
        // filter out non races
        let races = self.sessions.filter({ $0.session.sessionType == "R" })
        if races.isEmpty {
            return nil
        } else {
            let firstRace = races.min { $0.raceStartTime < $1.raceStartTime }
            let firstRaceDate = firstRace!.raceStartTime
            return dateAsString(date: firstRaceDate)
        }
    }
    
    var lastRaceDate: String? {
        // filter out non races
        let races = self.sessions.filter({ $0.session.sessionType == "R" })
        if races.isEmpty {
            return nil
        } else {
            let lastRace = races.max { $0.raceStartTime < $1.raceStartTime }
            let lastRaceDate = lastRace!.raceStartTime
            return dateAsString(date: lastRaceDate)
        }
    }
    
    var firstSessionDate: String? {
        
        let firstSession = self.sessions.first 
        let firstSessionDate = firstSession!.raceStartTime
        return dateAsString(date: firstSessionDate)
        
    }
    
    var lastSessionDate: String? {
        
        let lastSession = self.sessions.last
        let lastSessionDate = lastSession!.raceStartTime
        return dateAsString(date: lastSessionDate)
    }
    
    func dateAsString(date: Date) -> String {
        let formatter = DateFormatter()
        if date.compare(.isThisYear) {
            formatter.dateFormat = "MMM d"
        } else {
            formatter.dateFormat = "MMM d yyyy"
        }
        
        return formatter.string(from: date)
    }
    
    func timeAsString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date)
    }
    
    func timeFromNow() -> String {
        
        let firstSession = self.sessions.first
        let firstSessionDate = firstSession!.raceStartTimeInRegion
        return firstSessionDate.toRelative(since: Date().convertTo(region: Region.UTC))
    }
}

var exampleEvent = RaceEvent(eventId: 999, eventName: "British Grand Prix", seriesIds: ["f1", "f2", "f3", "supercup"], sessions: [exampleSession])

//var exampleEvent = RaceEvent(eventId: 999, eventName: "British Grand Prix", sessions: [exampleSession, exampleSession2])

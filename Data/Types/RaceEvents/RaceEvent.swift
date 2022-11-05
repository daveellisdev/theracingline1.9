//
//  RaceEvent.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation
import SwiftDate

struct RaceEvent: Codable, Identifiable, Hashable {
    
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
    
    var sessionInProgress: Bool? {
        let liveSessions = self.sessions.filter({ $0.sessionInProgress != nil && $0.sessionInProgress != false})
        
        return !liveSessions.isEmpty
    }
    
    var eventInProgress: Bool? {
        // get first & last sessions
        let firstSession = self.sessions.first
        let firstSessionDate = firstSession!.raceStartTime
        let lastSession = self.sessions.last
        let lastSessionDate = lastSession!.raceStartTime
        
        // get first & last sessions
        let races = self.sessions.filter({ $0.session.sessionType == "R" })
        let firstRaceDate: Date?
        
        if races.isEmpty {
            firstRaceDate = nil
        } else {
            let firstRace = races.min { $0.raceStartTime < $1.raceStartTime }
            firstRaceDate = firstRace!.raceStartTime
        }
        
        let lastRaceDate: Date?
        if races.isEmpty {
            lastRaceDate = nil
        } else {
            let lastRace = races.max { $0.raceStartTime < $1.raceStartTime }
            lastRaceDate = lastRace!.raceStartTime
        }
        
        // get end time of last race
        let lastRaceFinishingTime: Date?
        if lastRaceDate != nil {
            let lastRace = races.max { $0.raceStartTime < $1.raceStartTime }
            lastRaceFinishingTime = lastRace!.raceEndTime
        } else {
            lastRaceFinishingTime = nil
        }
        
        let firstGreen: Date
        if firstRaceDate != nil {
            firstGreen = firstSessionDate
        } else if firstRaceDate! < firstSessionDate {
            firstGreen = firstRaceDate!
        } else {
            firstGreen = firstSessionDate
        }
        
        let chequer: Date?
        if lastRaceFinishingTime != nil {
            chequer = lastRaceFinishingTime!
        } else if lastRaceDate! < lastSessionDate {
            chequer = lastRaceDate!
        } else {
            chequer = lastSessionDate
        }
        
        let now = Date()
        
        if chequer == nil {
            return nil
        } else if now > firstGreen && now < chequer! {
            return true
        } else {
            return false
        }
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: RaceEvent, rhs: RaceEvent) -> Bool {
        return lhs.id == rhs.id
    }
}

var exampleEvent = RaceEvent(eventId: 999, eventName: "British Grand Prix", seriesIds: ["f1", "f2", "f3", "supercup"], sessions: [exampleSession])

//var exampleEvent = RaceEvent(eventId: 999, eventName: "British Grand Prix", sessions: [exampleSession, exampleSession2])

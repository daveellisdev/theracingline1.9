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
    
    // MARK: - event status

    func sessionInProgress() -> Bool? {
        let liveSessions = self.sessions.filter({ $0.isInProgress() != false})
        
        return !liveSessions.isEmpty
    }
    
    func eventInProgress() -> Bool? {
        // get first & last sessions
        let firstSession = self.sessions.first
        let firstSessionDate = firstSession!.raceStartTime()
        let lastSession = self.sessions.last
        let lastSessionDate = lastSession!.raceStartTime()
        
        // get first & last sessions
        let races = self.sessions.filter({ $0.session.sessionType == "R" })
        let firstRaceDate: Date?
        
        if races.isEmpty {
            firstRaceDate = nil
        } else {
            let firstRace = races.min { $0.raceStartTime() < $1.raceStartTime() }
            firstRaceDate = firstRace!.raceStartTime()
        }
        
        let lastRaceDate: Date?
        if races.isEmpty {
            lastRaceDate = nil
        } else {
            let lastRace = races.max { $0.raceStartTime() < $1.raceStartTime() }
            lastRaceDate = lastRace!.raceStartTime()
        }
        
        // get end time of last race
        let lastRaceFinishingTime: Date?
        if lastRaceDate != nil {
            let lastRace = races.max { $0.raceStartTime() < $1.raceStartTime() }
            lastRaceFinishingTime = lastRace!.raceEndTime()
        } else {
            lastRaceFinishingTime = nil
        }
        
        let firstGreen: Date
        if firstRaceDate == nil {
            firstGreen = firstSessionDate
        } else {
            firstGreen = firstRaceDate!
        }
        
        let chequer: Date?
        if lastRaceFinishingTime != nil {
            chequer = lastRaceFinishingTime!
        } else if lastRaceDate != nil && lastRaceDate! < lastSessionDate {
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
    
    func eventComplete() -> Bool {
        let numberOfSessions = self.sessions.count
        let numberOfCompletedSessions = self.sessions.filter { $0.isComplete() }.count
                
        if numberOfSessions > numberOfCompletedSessions {
            return false
        } else {
            return true
        }
    }
    
    func eventCompleteWithinLastWeek() -> Bool {
        
        return false
    }
    

    // MARK: - start and end dates
    
    func firstRaceDate() -> Date {
        // filter out non races
        let races = self.sessions.filter({ $0.session.sessionType == "R" })
        if races.isEmpty {
            // if no races then return first session
            return self.firstSessionDate()
        } else {
            let firstRace = races.min { $0.raceStartTime() < $1.raceStartTime() }
            return firstRace!.raceStartTime()
        }
    }
    
    func firstSessionDate() -> Date {
        
        let firstSession = self.sessions.first
        return firstSession!.raceStartTime()
    }
    
    // MARK: - string returns
    
    func firstRaceDateAsString() -> String? {
        
        let weekDays = [
                "Sun",
                "Mon",
                "Tue",
                "Wed",
                "Thur",
                "Fri",
                "Sat"
            ]
        
        // filter out non races
        let races = self.sessions.filter({ $0.session.sessionType == "R" })
        if races.isEmpty {
            return nil
        } else {
            let firstRace = races.min { $0.raceStartTime() < $1.raceStartTime() }
            let firstRaceDate = firstRace!.raceStartTime()
            
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: firstRaceDate)
            let weekDayString = weekDays[weekDay-1]
            let dateAsString = dateAsString(date: firstRaceDate)
            
            return "\(weekDayString) \(dateAsString)"
        }
    }
    
    func lastRaceDateAsString() -> String? {
        
        let weekDays = [
                "Sun",
                "Mon",
                "Tue",
                "Wed",
                "Thur",
                "Fri",
                "Sat"
            ]
        
        // filter out non races
        let races = self.sessions.filter({ $0.session.sessionType == "R" })
        if races.isEmpty {
            return nil
        } else {
            let lastRace = races.max { $0.raceStartTime() < $1.raceStartTime() }
            let lastRaceDate = lastRace!.raceStartTime()
            
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: lastRaceDate)
            let weekDayString = weekDays[weekDay-1]
            let dateAsString = dateAsString(date: lastRaceDate)
            
            return "\(weekDayString) \(dateAsString)"
        }
    }
    
    func firstSessionDateAsString() -> String {
        
        let weekDays = [
                "Sun",
                "Mon",
                "Tue",
                "Wed",
                "Thur",
                "Fri",
                "Sat"
            ]
        
        let firstSession = self.sessions.first 
        let firstSessionDate = firstSession!.raceStartTime()
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: firstSessionDate)
        let weekDayString = weekDays[weekDay-1]
        let dateAsString = dateAsString(date: firstSessionDate)
        
        return "\(weekDayString) \(dateAsString)"
        
    }
    
    func lastSessionDateAsString() -> String {
        
        let weekDays = [
                "Sun",
                "Mon",
                "Tue",
                "Wed",
                "Thur",
                "Fri",
                "Sat"
            ]
        
        let lastSession = self.sessions.last
        let lastSessionDate = lastSession!.raceStartTime()
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: lastSessionDate)
        let weekDayString = weekDays[weekDay-1]
        let dateAsString = dateAsString(date: lastSessionDate)
        
        return "\(weekDayString) \(dateAsString)"
    }
    

    // MARK: - UTILITIES
    
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
    
    func sessionsSortedByDate() -> [Session] {
        let sortedSessions = self.sessions.sorted { $0.raceStartTime() < $1.raceStartTime() }
        
        return sortedSessions
    }
    
    func firstSessionTimeFromNow() -> String {
        
        let firstSession = self.sessions.first
        let firstSessionDate = firstSession!.raceStartTimeInRegion()
        return firstSessionDate.toRelative(since: Date().convertTo(region: Region.UTC))
    }
    
    func shouldBeVisible(visibleSeries: [String:Bool]) -> Bool {
        
        let seriesIds = self.seriesIds
        
        var visible = false
        
        seriesIds.forEach { seriesId in
            if visibleSeries[seriesId] == true {
                visible = true
            }
        }
        
        return visible
    }
    
    // MARK: - REQUIRED
    
    static func ==(lhs: RaceEvent, rhs: RaceEvent) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - EXAMPLE EVENTS

var exampleEvent = RaceEvent(eventId: 999, eventName: "British Grand Prix", seriesIds: ["f1", "f2", "f3", "supercup"], sessions: [exampleSession])

//var exampleEvent = RaceEvent(eventId: 999, eventName: "British Grand Prix", sessions: [exampleSession, exampleSession2])

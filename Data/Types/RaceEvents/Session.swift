//
//  Session.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation
import SwiftDate

struct Session: Codable, Identifiable {
    let id: Int
    let seriesId: String
    let circuit: CircuitInfo
    let session: SessionInfo
    let date: SessionDate
    let duration: Duration
    
    var raceStartTime: Date {
        // strip the string down
        
        let timeArray = self.date.date.split(separator: " ")
        let timeString = String("\(timeArray[1]) \(timeArray[2]) \(timeArray[3]) \(timeArray[4])".dropLast(3))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd y HH:mm"
        
        let raceStartTime = formatter.date(from: timeString)
        return raceStartTime!
    }
    
    func raceStartTimeAsString() -> String {
        let formatter = DateFormatter()
        if raceStartTime.compare(.isThisYear) {
            formatter.dateFormat = "MMM d"
        } else {
            formatter.dateFormat = "MMM d yyyy"
        }
        
        return formatter.string(from: raceStartTime)
    }
    
    var raceStartTimeInRegion: DateInRegion {
        // strip the string down
        
        let timeArray = self.date.date.split(separator: " ")
        let timeString = String("\(timeArray[1]) \(timeArray[2]) \(timeArray[3]) \(timeArray[4])".dropLast(3))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd y HH:mm"
        
        let raceStartTime = formatter.date(from: timeString)
        let dateInUTC = raceStartTime!.convertTo(region: Region.UTC)
        return dateInUTC
    }
    
    var raceEndTime: Date? {

        let durationLength = self.duration.durationMinutes
        let raceEndTime = self.raceStartTime + durationLength.minutes
        return raceEndTime

    }
    
    var sessionInProgress: Bool? {
        if raceEndTime == nil {
            return nil
        }
        
        let now = Date()
        if now > raceStartTime && now < raceEndTime! {
            return true
        } else {
            return false
        }
    }
    
    var sessionComplete: Bool? {
        if raceEndTime == nil {
            return nil
        }
        
        let now = Date()
        if now > raceEndTime! {
            return true
        } else {
            return false
        }
    }
    
    var getDurationText: String? {
     
        if duration.tba != nil {
            return nil
        }
        
        let durationType = duration.durationType
        let durationValue = duration.duration
        
        let durationTypeString: String
        
        switch durationType {
        case "T":
            if durationValue < 60 {
                durationTypeString = " Minutes"
            } else {
                if durationValue % 60 == 0{
                    if durationValue / 60 == 1 {
                        return "\(Int(floor(Double(durationValue)/60))) Hour"
                    } else {
                        return "\(Int(floor(Double(durationValue)/60))) Hours"
                    }
                } else {
                    let hours = Int(floor(Double(durationValue)/60))
                    let minutes = durationValue % 60
                    
                    if hours == 1 {
                        return "\(Int(floor(Double(durationValue)/60))) Hour \(minutes) Minutes"
                    } else {
                        return "\(Int(floor(Double(durationValue)/60))) Hours \(minutes) Minutes"
                    }
                }
            }
        case "L":
            durationTypeString = "Laps"
        case "DM":
            durationTypeString = "Miles"
        case "DKM":
            durationTypeString = "km"
        case "AD":
            durationTypeString = "All Day Event"
        default:
            return nil
        }
        if durationType == "T" {
            // time
        } else if durationType == "L" {
            
        }
        
        return "\(durationValue) \(durationTypeString)"
        
    }
    
    var timeFromNow: String {
        
          return self.raceStartTime.toRelative(since: Date().convertTo(region: Region.UTC))
    }
}

var exampleSession = Session(id: 123, seriesId: "f1", circuit: exampleCircuitInfo, session: exampleSessionInfo, date: exampleSessionDate, duration: exampleDuration)
var exampleSession2 = Session(id: 123, seriesId: "f1", circuit: exampleCircuitInfo2, session: exampleSessionInfo2, date: exampleSessionDate2, duration: exampleDuration2)
var exampleSession3 = Session(id: 123, seriesId: "f1", circuit: exampleCircuitInfo2, session: exampleSessionInfo2, date: exampleSessionDate3, duration: exampleDuration3)

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
    let duration: Duration?
    
    var raceStartTime: Date {
        // strip the string down
        
        let timeArray = self.date.date.split(separator: " ")
        let timeString = String("\(timeArray[1]) \(timeArray[2]) \(timeArray[3]) \(timeArray[4])".dropLast(3))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd y HH:mm"
        
        let raceStartTime = formatter.date(from: timeString)
        return raceStartTime!
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
        if duration != nil {
            if duration!.durationType == "T" {
                let durationLength = self.duration!.duration
                let raceEndTime = self.raceStartTime + durationLength.minutes
                return raceEndTime
            }
        }
        return nil
    }
}

var exampleSession = Session(id: 123, seriesId: "f1", circuit: exampleCircuitInfo, session: exampleSessionInfo, date: exampleSessionDate, duration: exampleDuration)
var exampleSession2 = Session(id: 123, seriesId: "f1", circuit: exampleCircuitInfo2, session: exampleSessionInfo2, date: exampleSessionDate2, duration: exampleDuration2)

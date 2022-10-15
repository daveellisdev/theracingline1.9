//
//  Session.swift
//  theracingline
//
//  Created by Dave on 15/10/2022.
//

import Foundation

// potentially add Equatable to the class protocols
class Session: ObservableObject, Identifiable, Codable, Equatable, Hashable {
        
    var sessionID = 0
    var weekendID = 0
    var seriesID = ""
    var seriesName = ""
    var darkRGB = [0, 0, 0]
    var lightRGB = [0, 0, 0]
    var seriesType = ""
    var circuit = ""
    var circuitLayout = ""
    var eventName = ""
    var sessionName = ""
    var sessionType = ""
    var durationType = ""
    var duration = 0
    var durationTBA = true
    var date = Date()
    var raceTimeTBA = true
    var estimatedRaceTime = 0
    var weatherMain = ""
    var weatherDescription = ""
    var weatherTemp = 0.0
    var weatherRain = 0.0
    
    enum CodingKeys: String, CodingKey {
        case sessionID
        case weekendID
        case seriesID
        case seriesName
        case darkRGB
        case lightRGB
        case seriesType
        case circuit
        case circuitLayout
        case eventName
        case sessionName
        case sessionType
        case durationType
        case duration
        case durationTBA
        case date
        case raceTimeTBA
        case estimatedRaceTime
        case weatherMain
        case weatherDescription
        case weatherTemp
        case weatherRain
    }
    
    static func ==(lhs: Session, rhs: Session) -> Bool {
        return lhs.sessionID == rhs.sessionID && lhs.weekendID == rhs.weekendID && lhs.seriesID == rhs.seriesID && lhs.seriesName == rhs.seriesName && lhs.darkRGB == rhs.darkRGB && lhs.lightRGB == rhs.lightRGB && lhs.seriesType == rhs.seriesType && lhs.circuit == rhs.circuit && lhs.circuitLayout == rhs.circuitLayout && lhs.eventName == rhs.eventName && lhs.sessionName == rhs.sessionName && lhs.sessionType == rhs.sessionType && lhs.durationType == rhs.durationType && lhs.duration == rhs.duration && lhs.durationTBA == rhs.durationTBA && lhs.date == rhs.date && lhs.raceTimeTBA == rhs.raceTimeTBA && lhs.estimatedRaceTime == rhs.estimatedRaceTime && lhs.weatherMain == rhs.weatherMain && lhs.weatherDescription == rhs.weatherDescription && lhs.weatherTemp == rhs.weatherTemp &&
        lhs.weatherRain == rhs.weatherRain
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(sessionID, forKey: CodingKeys.sessionID)
        try container.encode(weekendID, forKey: CodingKeys.weekendID)
        try container.encode(seriesID, forKey: CodingKeys.seriesID)
        try container.encode(seriesName, forKey: CodingKeys.seriesName)
        try container.encode(darkRGB, forKey: CodingKeys.darkRGB)
        try container.encode(lightRGB, forKey: CodingKeys.lightRGB)
        try container.encode(seriesType, forKey: CodingKeys.seriesType)
        try container.encode(circuit, forKey: CodingKeys.circuit)
        try container.encode(circuitLayout, forKey: CodingKeys.circuitLayout)
        try container.encode(eventName, forKey: CodingKeys.eventName)
        try container.encode(sessionName, forKey: CodingKeys.sessionName)
        try container.encode(sessionType, forKey: CodingKeys.sessionType)
        try container.encode(durationType, forKey: CodingKeys.durationType)
        try container.encode(duration, forKey: CodingKeys.duration)
        try container.encode(durationTBA, forKey: CodingKeys.durationTBA)
        try container.encode(date, forKey: CodingKeys.date)
        try container.encode(raceTimeTBA, forKey: CodingKeys.raceTimeTBA)
        try container.encode(estimatedRaceTime, forKey: CodingKeys.estimatedRaceTime)
        try container.encode(weatherMain, forKey: CodingKeys.weatherMain)
        try container.encode(weatherDescription, forKey: CodingKeys.weatherDescription)
        try container.encode(weatherTemp, forKey: CodingKeys.weatherTemp)
        try container.encode(weatherRain, forKey: CodingKeys.weatherRain)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        sessionID = try values.decode(Int.self, forKey: .sessionID)
        weekendID = try values.decode(Int.self, forKey: .weekendID)
        seriesID = try values.decode(String.self, forKey: .seriesID)
        seriesName = try values.decode(String.self, forKey: .seriesName)
        darkRGB = try values.decode([Int].self, forKey: .darkRGB)
        lightRGB = try values.decode([Int].self, forKey: .lightRGB)
        seriesType = try values.decode(String.self, forKey: .seriesType)
        circuit = try values.decode(String.self, forKey: .circuit)
        circuitLayout = try values.decode(String.self, forKey: .circuitLayout)
        eventName = try values.decode(String.self, forKey: .eventName)
        sessionName = try values.decode(String.self, forKey: .sessionName)
        sessionType = try values.decode(String.self, forKey: .sessionType)
        durationType = try values.decode(String.self, forKey: .durationType)
        duration = try values.decode(Int.self, forKey: .duration)
        durationTBA = try values.decode(Bool.self, forKey: .durationTBA)
        date = try values.decode(Date.self, forKey: .date)
        raceTimeTBA = try values.decode(Bool.self, forKey: .raceTimeTBA)
        estimatedRaceTime = try values.decode(Int.self, forKey: .estimatedRaceTime)
        weatherMain = try values.decode(String.self, forKey: .weatherMain)
        weatherDescription = try values.decode(String.self, forKey: .weatherDescription)
        weatherTemp = try values.decode(Double.self, forKey: .weatherTemp)
        weatherRain = try values.decode(Double.self, forKey: .weatherRain)
    }
    
    init() {
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

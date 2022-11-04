//
//  Session.swift
//  theracingline
//
//  Created by Dave on 25/10/2022.
//
//
//import Foundation
//import SwiftDate
//
//struct SessionOLD: Codable, Identifiable {
//
//    let id = UUID()
//    let sessionId: Int
//    let weekendId: Int
//    let seriesId: String
//    let seriesName: String
//    let darkRGB: [Int]
//    let lightRGB: [Int]
//    let seriesType: String
//    let circuit: String
//    let circuitLayout: String?
//    let eventName: String?
//    let sessionName: String
//    let sessionType: String
//    let durationType: String
//    let duration: Int?
//    let durationTBA: Bool?
//    let date: String
//    let raceTimeTBA: Bool?
//    let estimatedRaceTime: Int?
//    let weather: Weather?
//
//    var startDate: Date {
//        let dateInRegion = self.date.toDate()!
//        return dateInRegion.date
//    }
//
//    var endDate: Date? {
//        if estimatedRaceTime != nil {
//            return self.startDate + self.estimatedRaceTime!.minutes
//        } else {
//            return nil
//        }
//    }
//
//    func hasPassed() -> Bool {
//        let currentDate = Date()
//
//        return currentDate > self.startDate ? true : false
//    }
//
//    func inProgress() -> Bool? {
//        let currentDate = Date()
//
//        if endDate != nil {
//            return currentDate > self.startDate && currentDate < self.endDate! ? true : false
//        } else {
//            return nil
//        }
//    }
//
//    func dateAsString() -> String {
//        let formatter = DateFormatter()
//        if self.startDate.compare(.isThisYear) {
//            formatter.dateFormat = "MMM d"
//        } else {
//            formatter.dateFormat = "MMM d yyyy"
//        }
//
//        return formatter.string(from: self.startDate)
//    }
//
//    func timeAsString() -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm"
//
//        return formatter.string(from: self.startDate)
//    }
//}
//
//struct Weather: Codable {
//    let main: String
//    let description: String
//    let temp: Int
//    let rain: Int
//}
//
//enum SeriesType: String, Codable {
//    case singleSeater
//    case sportsCar
//    case touringCar
//    case stockCar
//    case rally
//    case bike
//    case other
//}
//
//enum SessionType: String, Codable {
//    case testing
//    case practice
//    case qualifying
//    case race
//}
//
//enum DurationType: String, Codable {
//    case time
//    case laps
//    case distanceKm
//    case distanceMiles
//    case allDay
//    case noDistance
//}
//
//var sampleSession1: Session {
//    let weather = Weather(main: "Sunny", description: "Sunny, light clouds", temp: 303, rain: 0)
//    let session = Session(sessionId: 123, weekendId: 234, seriesId: "f1", seriesName: "Formula 1", darkRGB: [175, 34, 34], lightRGB: [237, 33, 58], seriesType: "Single Seater", circuit: "Sakhir", circuitLayout: "Grand Prix", eventName: "Pre-Season Testing", sessionName: "Day 1 - Morning", sessionType: "T", durationType: "T", duration: 180, durationTBA: false, date: "2023-02-23T06:00:00.000Z", raceTimeTBA: false, estimatedRaceTime: 180, weather: weather)
//    return session
//}
//
//var sampleSession2: Session {
//    let weather = Weather(main: "Cloudy", description: "Light cloud cover", temp: 302, rain: 0)
//    let session = Session(sessionId: 123, weekendId: 234, seriesId: "f1", seriesName: "Formula 1", darkRGB: [175, 34, 34], lightRGB: [237, 33, 58], seriesType: "Single Seater", circuit: "Sakhir", circuitLayout: "Grand Prix", eventName: "Pre-Season Testing", sessionName: "Day 1 - Afternoon", sessionType: "T", durationType: "T", duration: 180, durationTBA: false, date: "2023-02-23T10:00:00.000Z", raceTimeTBA: false, estimatedRaceTime: 180, weather: weather)
//    return session
//}

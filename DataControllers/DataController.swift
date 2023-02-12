//
//  DataController.swift
//  theracingline
//
//  Created by Dave on 25/10/2022.
//

import Foundation
import SwiftUI
import SwiftDate

class DataController: ObservableObject {
    
    static var shared = DataController()
    
    @Published var series: [Series] = []
    @Published var seriesSingleSeater: [Series] = []
    @Published var seriesSportscars: [Series] = []
    @Published var seriesTouringcars: [Series] = []
    @Published var seriesStockcars: [Series] = []
    @Published var seriesRally: [Series] = []
    @Published var seriesBikes: [Series] = []
    @Published var seriesOther: [Series] = []
//    @Published var seriesList: [SeriesList] = []
    
    @Published var circuits: [Circuit] = []
    
    @Published var events: [RaceEvent] = []
    @Published var eventsInProgress: [RaceEvent] = []
    @Published var eventsInProgressAndUpcoming: [RaceEvent] = []

    @Published var sessions: [Session] = []
    @Published var sessionsUpcomingButNotInProgress: [Session] = []
    @Published var sessionsUpcomingButNotInTheNextTwelveHours: [Session] = []
    @Published var sessionsNextTenUpcomingButNotInProgress: [Session] = []
    @Published var sessionsNextTenUpcomingButNotInTheNextTwelveHours: [Session] = []

    @Published var sessionsInProgressAndUpcoming: [Session] = []
    @Published var liveSessions: [Session] = []
    @Published var sessionsWithinNextTwelveHours: [Session] = []
    @Published var sessionsWithinNextTwelveHoursButNotLive: [Session] = []
    
    @Published var seriesSettings: [SeriesSavedData] = []
    
    init() {
        // load user saved settings
        
        // load previously downloaded json
        
        // download new json
        downloadData()
    }
    
    var timeLineHeight: CGFloat {
        return CGFloat((sessionsWithinNextTwelveHours.count * 50) - 20)
    }
    
    // MARK: - DOWNLOAD DATA
    
    func downloadData() {
        print("DownloadDataRun")
        
        let keys = Keys()
        let key = keys.getKey()
        let binUrl = keys.getFullDataUrl()
        
        guard let url = URL(string: binUrl) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(key, forHTTPHeaderField: "X-ACCESS-KEY")
        request.addValue("false", forHTTPHeaderField: "X-BIN-META")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("API CALL FAILED")
                print(error!)
                return
            }

            guard let data = data else {
                return
            }
            
            self.decodeData(data: data)

        }.resume()
        
    } // DOWNLOADDATA
    
    func createSessions(events: [RaceEvent]) -> [Session] {

        var sessions: [Session] = []
        for event in events {
            sessions.append(contentsOf: event.sessions)
        }
        sessions.sort { $0.raceStartTime() < $1.raceStartTime() }
        
        return sessions
    }
    
    // MARK: - DECODE DATA
    
    func decodeData(data: Data) {
        do {
            let json = try JSONDecoder().decode(FullDataDownload.self, from: data)

            DispatchQueue.main.async {
                
                let now = Date()
                let twelveHoursAway = Date() + 12.hours

                // series
                self.series = json.series
                self.seriesSingleSeater = self.series.filter{ $0.seriesInfo.type == "Single Seater"}
                self.seriesSportscars = self.series.filter{ $0.seriesInfo.type == "Sportscars"}
                self.seriesTouringcars = self.series.filter{ $0.seriesInfo.type == "Touring Cars"}
                self.seriesStockcars = self.series.filter{ $0.seriesInfo.type == "Stock Cars"}
                self.seriesRally = self.series.filter{ $0.seriesInfo.type == "Rally"}
                self.seriesBikes = self.series.filter{ $0.seriesInfo.type == "Bikes"}
                self.seriesOther = self.series.filter{ $0.seriesInfo.type == "Other"}
                print("Series Done")
                
                // circuits
                self.circuits = json.circuits
                print("Circuits Done")
                
                // events
                var sortedEvents = json.events
                sortedEvents.sort {$0.firstRaceDate() < $1.firstRaceDate()}
                
                self.events = sortedEvents
                self.eventsInProgress = sortedEvents.filter {
                    if $0.eventInProgress() != nil && $0.eventInProgress()! {
                        return true
                    } else {
                        return false
                    }
                ;}
                
                self.eventsInProgressAndUpcoming = sortedEvents.filter { !$0.eventComplete() }
                print("Events Done")
                
                // sessions
                var sortedSessions = self.createSessions(events: self.events)
                sortedSessions.sort{ $0.raceStartTime() < $1.raceStartTime()}
            
                self.sessions = sortedSessions
                self.sessionsInProgressAndUpcoming = sortedSessions.filter { !$0.isComplete() }
                self.sessionsUpcomingButNotInProgress = sortedSessions.filter { !$0.isComplete() && !$0.isInProgress() }
                self.sessionsUpcomingButNotInTheNextTwelveHours = sortedSessions.filter { !$0.isComplete() && !$0.isInProgress() && $0.raceStartTime() > twelveHoursAway }

                self.sessionsNextTenUpcomingButNotInProgress = Array(self.sessionsUpcomingButNotInProgress.prefix(10))
                self.sessionsNextTenUpcomingButNotInTheNextTwelveHours = Array(self.sessionsUpcomingButNotInTheNextTwelveHours.prefix(10))


                self.liveSessions = sortedSessions.filter { $0.isInProgress() }
                self.sessionsWithinNextTwelveHours = sortedSessions.filter { $0.isInProgress() || ($0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now) }
                self.sessionsWithinNextTwelveHours.reverse()
                self.sessionsWithinNextTwelveHoursButNotLive = sortedSessions.filter { $0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now }
                print("Sessions Done")
                
                print("Decoding Finished")
                
                self.saveSeriesAndSessionData(data: data)
                print("Saved Data")
            } // dispatchqueue
        } catch let jsonError as NSError {
            print(jsonError)
            print(jsonError.underlyingErrors)
            print(jsonError.localizedDescription)
        } // do catch
    }
    
    // MARK: - LOAD DATA
    
    func loadSeriesData() {
        DispatchQueue.global().async {
            
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
                
                if let data = defaults.data(forKey: "seriesAndSessionData"){
                    self.decodeData(data: data)
                } // if let data
            } // if let defaults
        } // dispatchqueee
    }
    
    // MARK: - SAVE SERIES DATA
    
    func saveSeriesAndSessionData(data: Data) {
        DispatchQueue.global().async {
            
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {

                defaults.set(data, forKey: "seriesAndSessionData")
                defaults.synchronize() // MAYBE DO NOT NEED
                
            } // if let defaults
            
        } // dispatch queue
    }
    
    // MARK: - LOAD SERIES DATA
    
    // MARK: - INITIALISE SAVED SETTINGS
    
    // Visible, Favourite, Notifications
    
    // Notifications - Offset, Sessions, Sound
    // MARK: - SAVING SAVED SETTINGS
    
    // MARK: - LOADING SAVED SETTINGS
    
    // MARK: - UTILITIES
    
    func getSeriesById(seriesId: String) -> Series? {
        if let index = self.series.firstIndex(where: {$0.seriesInfo.id == seriesId}) {
            return series[index]
        } else {
            return nil
        }
    }
    
    func getCircuitByName(circuit: String) -> Circuit? {
        if let index = self.circuits.firstIndex(where: {$0.circuit == circuit}) {
            return circuits[index]
        } else {
            return nil
        }
    }
    
    func getEventsBySeriesId(seriesId: String) -> [RaceEvent] {
        let events = self.events.filter { $0.seriesIds.contains(seriesId) }
        return events
    }
} // CONTROLER

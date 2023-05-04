//
//  DataController.swift
//  theracingline
//
//  Created by Dave on 25/10/2022.
//

import Foundation
import SwiftUI
import SwiftDate
import StoreKit


class DataController: ObservableObject {
        
    static var shared = DataController()
    
    // MARK: - SERIES
    @Published var series: [Series] = []
    
    @Published var visibleSeries: [String:Bool] = [:]
    @Published var favouriteSeries: [String:Bool] = [:]
    @Published var notificationSeries: [String:Bool] = [:]
    
    @Published var applicationSavedSettings: ApplicationSavedSettings = ApplicationSavedSettings(raceNotifications: false, qualifyingNotifications: false, practiceNotifications: false, testingNotifications: false, notificationOffset: 900, notificationSound: "flyby_notification_bell.tiff")
    
    var seriesFiltered: [Series] {
        return self.series.filter { visibleSeries[$0.seriesInfo.id] ?? true }
    }
    
    var seriesSingleSeater: [Series] {
        return self.series.filter { $0.seriesInfo.type == "Single Seater"}
    }
    var seriesSportscars: [Series] {
        return self.series.filter { $0.seriesInfo.type == "Sportscars"}
    }
    var seriesTouringcars: [Series] {
        return self.series.filter { $0.seriesInfo.type == "Touring Cars"}
    }
    var seriesStockcars: [Series] {
        return self.series.filter { $0.seriesInfo.type == "Stock Cars"}
    }
    var seriesRally: [Series] {
        return self.series.filter { $0.seriesInfo.type == "Rally"}
    }
    var seriesBikes: [Series] {
        return self.series.filter { $0.seriesInfo.type == "Bikes"}
    }
    var seriesOther: [Series] {
        return self.series.filter { $0.seriesInfo.type == "Other"}
    }
    
    // MARK: - CIRCUITS
    @Published var circuits: [Circuit] = []
    
    // MARK: - EVENTS
    @Published var events: [RaceEvent] = []
    
    var eventsInProgressAndUpcoming: [RaceEvent] {
        return self.events.filter { !$0.eventComplete() && $0.shouldBeVisible(visibleSeries: self.visibleSeries) }
    }
    
    // MARK: - SESSIONS

    @Published var unfilteredSessions: [Session] = []
    
    // SESSIONS VISIBLE
    var sessions: [Session] {
        return self.unfilteredSessions.filter { self.visibleSeries[$0.seriesId] ?? true }
    }
    var sessionsInProgressAndUpcoming: [Session] {
        return self.unfilteredSessions.filter { self.visibleSeries[$0.seriesId] ?? true  && !$0.isComplete() }
    }
//    var sessionsUpcoming: [Session] {
//        return self.unfilteredSessions.filter { self.visibleSeries[$0.seriesId] ?? true  && !$0.isComplete() && !$0.isInProgress() }
//    }
    var liveSessions: [Session] {
        return self.unfilteredSessions.filter { self.visibleSeries[$0.seriesId] ?? true  && $0.isInProgress() }
    }

    // favourite filtered
    var favouriteSessions: [Session] {
        return self.sessions.filter { self.favouriteSeries[$0.seriesId] ?? true }
    }
    var favouriteSessionsInProgressAndUpcoming: [Session] {
        return self.favouriteSessions.filter { !$0.isComplete() }
    }
    var favouriteLiveSessions: [Session] {
        return self.favouriteSessions.filter { $0.isInProgress() }
    }
    
    // notification sessions
    
        
//    var timeLineHeight: CGFloat {
//        return CGFloat((sessionsWithinNextTwelveHours.count * 50) - 20)
//    }
    
    // MARK: - DOWNLOAD DATA
    
    func downloadData() {
//        print("Downloading Data \(Date())")
        
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
            
            // decode and dispatch data
            self.decodeData(data: data)
            
//            print("Data Downloaded Data \(Date())")
        }.resume()
        
    } // DOWNLOADDATA
    
    func createSessions(events: [RaceEvent]) -> [Session] {
//        print("createSessionsHit")
        var sessions: [Session] = []
        for event in events {
            sessions.append(contentsOf: event.sessions)
        }
        sessions.sort { $0.raceStartTime() < $1.raceStartTime() }
        return sessions
        
    }
    
    // MARK: - DECODE DATA
    
    func decodeData(data: Data) {
        print("Decoding Data \(Date())")

        do {
                let json = try JSONDecoder().decode(FullDataDownload.self, from: data)
                
                var sortedEvents = json.events
                sortedEvents.sort {$0.firstRaceDate() < $1.firstRaceDate()}
                
                var sortedSessions = self.createSessions(events: sortedEvents)
                sortedSessions.sort{ $0.raceStartTime() < $1.raceStartTime()}
                
                DispatchQueue.main.async {
                    
                    for series in json.series {
                        let seriesId = series.seriesInfo.id
                        
                        if self.visibleSeries[seriesId] == nil {
                            self.visibleSeries[seriesId] = false
                        }
                        
                        if self.favouriteSeries[seriesId] == nil {
                            self.favouriteSeries[seriesId] = true
                        }
                        
                        if self.notificationSeries[seriesId] == nil {
                            self.notificationSeries[seriesId] = true
                        }
                    }
                    
                    // series
                    self.series = json.series
                    //                print("Series Done")
                    
                    // circuits
                    self.circuits = json.circuits
                    //                print("Circuits Done")
                    
                    // events
                    self.events = sortedEvents
                    //                print("Events Done")
                    
                    // sessions
                    self.unfilteredSessions = sortedSessions
                    //                print("Sessions Done")
                    print("Data Decoded \(Date())")
                    
                    self.saveSeriesAndSessionData()
                } // dispatchqueue main
        } catch let jsonError as NSError {
            print(jsonError)
            print(jsonError.underlyingErrors)
            print(jsonError.localizedDescription)
        } // do catch
    }
    
    // MARK: - LOAD SERIES DATA
    
    func loadSeriesAndSessionData() {

        DispatchQueue.global().async {
            
            let decoder = JSONDecoder()
            
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
                
                if let data = defaults.data(forKey: "series"){
                    if let jsonSeries = try? decoder.decode([Series].self, from: data){
                        DispatchQueue.main.async {
                            self.series = jsonSeries
                        }
                    }
                }
                
                if let data = defaults.data(forKey: "circuits"){
                    if let jsonCircuits = try? decoder.decode([Circuit].self, from: data){
                        DispatchQueue.main.async {
                            self.circuits = jsonCircuits
                        }
                    }
                }
                
                if let data = defaults.data(forKey: "events"){
                    if let jsonEvents = try? decoder.decode([RaceEvent].self, from: data){
                        DispatchQueue.main.async {
                            self.events = jsonEvents
                        }
                    }
                }
                
                if let data = defaults.data(forKey: "sessions"){
                    if let jsonSessions = try? decoder.decode([Session].self, from: data){
                        DispatchQueue.main.async {
                            self.unfilteredSessions = jsonSessions
                        }
                    }
                }
            }
            
        }
//        DispatchQueue.global().async {
//
//            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
//
//                if let data = defaults.data(forKey: "seriesAndSessionData") {
//                    DispatchQueue.main.async{
//                        self.decodeData(data: data)
//                    }
//                    print("Loaded previous session Data \(Date())")
//                } // if let data
//            } // if let defaults
    }
    
    // MARK: - SAVE SERIES DATA
    
    func saveSeriesAndSessionData() {
        print("Saving Data")
        DispatchQueue.global().async {
            
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
                let encoder = JSONEncoder()
                
                // series
                if let encoded = try? encoder.encode(self.series) {
                    defaults.set(encoded, forKey: "series")
                }
                
                // circuits
                if let encoded = try? encoder.encode(self.circuits) {
                    defaults.set(encoded, forKey: "circuits")
                }
                
                // events
                if let encoded = try? encoder.encode(self.events) {
                    defaults.set(encoded, forKey: "events")
                }

                // sessions
                if let encoded = try? encoder.encode(self.sessions) {
                    defaults.set(encoded, forKey: "sessions")
                }

                defaults.synchronize() // MAYBE DO NOT NEED
                
                print("Saved Series Data")
            } // if let defaults
        } // dispatch queue
    }

    // MARK: - SAVING SAVED SETTINGS
    func saveSavedSettings() {
//        print("Saving Settings")
        DispatchQueue.global().async {
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
                
                // visible
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(self.visibleSeries) {
                    defaults.set(encoded, forKey: "visibilitySettings")
                }
                
                // fav
                if let encoded = try? encoder.encode(self.favouriteSeries) {
                    defaults.set(encoded, forKey: "favouriteSettings")
                }
                
                // notifications
                if let encoded = try? encoder.encode(self.notificationSeries) {
                    defaults.set(encoded, forKey: "notificationSettings")
                }
                
                if let encoded = try? encoder.encode(self.applicationSavedSettings) {
                    defaults.set(encoded, forKey: "applicationSavedSettings")
                }
            }
        }
    }
    
    // MARK: - UPDATED SERIES SAVED SETTINGS
    
    func updatedSeriesSavedSettings(type: ToggleType, series: Series, newValue: Bool) {
        let seriesId = series.seriesInfo.id
        switch type {
        case .visible:
            self.visibleSeries[seriesId] = newValue

            if !newValue {
                self.favouriteSeries[seriesId] = newValue
            }
            
        case .favourite:
            self.favouriteSeries[seriesId] = newValue
            
            if newValue {
                self.favouriteSeries[seriesId] = newValue
            }
            
        case .notification:
            self.notificationSeries[seriesId] = newValue
        }
    }
    
    // MARK: - LOADING SAVED SETTINGS
    func loadSavedSettings() {
        
        DispatchQueue.global().async {
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
                let decoder = JSONDecoder()
                
                if let data = defaults.data(forKey: "visibilitySettings") {
                    if let visibilitySettings = try? decoder.decode([String:Bool].self, from: data){
                        DispatchQueue.main.async{
                            self.visibleSeries = visibilitySettings
                            //                            print("Loaded Visibility Settings \(visibilitySettings)")
                        }
                    }
                } // if let data
                
                if let data = defaults.data(forKey: "favouriteSettings") {
                    if let favouriteSettings = try? decoder.decode([String:Bool].self, from: data){
                        DispatchQueue.main.async{
                            self.favouriteSeries = favouriteSettings
                            //                            print("Loaded Favourite Settings \(favouriteSettings)")
                        }
                    }
                } // if let data
                
                if let data = defaults.data(forKey: "notificationSettings") {
                    if let notificationSettings = try? decoder.decode([String:Bool].self, from: data){
                        DispatchQueue.main.async{
                            self.notificationSeries = notificationSettings
                            //                            print("Loaded Notification Settings \(notificationSettings)")
                        }
                    }
                } // if let data
                
                if let data = defaults.data(forKey: "applicationSavedSettings") {
                    if let applicationSavedSettings = try? decoder.decode(ApplicationSavedSettings.self, from: data) {
                        DispatchQueue.main.async {
                            self.applicationSavedSettings = applicationSavedSettings
                            //                            print("Loaded Application Saved Settings")
                        }
                    }
                } // if let data
            }
        } // dispatchque
    }
    
    // MARK: - UPDATE NOTIFICATION SAVED SETTINGS
    
    func updateNotificationSavedSettings(sessionTypeEnum: SessionType, newValue: Bool) {
        
        switch sessionTypeEnum {
        case .race:
            self.applicationSavedSettings.raceNotifications = newValue
        case .qualifying:
            self.applicationSavedSettings.qualifyingNotifications = newValue
        case .practice:
            self.applicationSavedSettings.practiceNotifications = newValue
        case .testing:
            self.applicationSavedSettings.testingNotifications = newValue
        }
    }
    
    // MARK: - CHECK VISFAVNOT SETTINGS
    
    func checkSessionSetting(type: ToggleType, seriesId: String) -> Bool {
        switch type {
        case .visible:
            return visibleSeries[seriesId] ?? true
        case .favourite:
            return favouriteSeries[seriesId] ?? true
        case .notification:
            return notificationSeries[seriesId] ?? true
        }
    }
    
    // MARK: - LOAD NOTIFICATION OFFSET
    
    func loadNotificationOffset() -> NotificationOffset {
        let fullTimeInSeconds = self.applicationSavedSettings.notificationOffset
        
        let days = (fullTimeInSeconds / 86400)
        let hours = (fullTimeInSeconds % 86400) / 3600
        let minutes = ((fullTimeInSeconds % 86400) % 3600) / 60

        let notificationOffset = NotificationOffset(days: days, hours: hours, minutes: minutes)
        
        return notificationOffset
    }
    
    // MARK: - UPDATE NOTIFICATION OFFSET
    func updateNotificationOffset(days: Int, hours: Int, minutes: Int) {
        let seconds = (days * 86400) + (hours * 3600) + (minutes * 60)
        self.applicationSavedSettings.notificationOffset = seconds
    }
    
    // MARK: - UTILITIES
    
    func getSeriesMap() -> [String: Series] {
        var map: [String: Series] = [:]
        for s in series {
            map[s.seriesInfo.id] = s
        }
        return map
    }
    
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
    
    func setAllSeriesAsVisible() {
        let allSeriesVisible = Dictionary(uniqueKeysWithValues: self.visibleSeries.map { key, value in (key, true) })
        self.visibleSeries = allSeriesVisible
    }
    
    func setAllAsFavourites() {
        let allSeriesFavourites = Dictionary(uniqueKeysWithValues: self.favouriteSeries.map { key, value in (key, true) })
        self.favouriteSeries = allSeriesFavourites
    }
    
    func setAllAsNotified() {
        let allSeriesNotifications = Dictionary(uniqueKeysWithValues: self.notificationSeries.map { key, value in (key, true) })
        self.notificationSeries = allSeriesNotifications
    }
    
    func setAllSeriesAsInvisible() {
        let allSeriesInvisible = Dictionary(uniqueKeysWithValues: self.visibleSeries.map { key, value in (key, false) })
        self.visibleSeries = allSeriesInvisible
    }
    
    func setAllAsNotFavourites() {
        let allSeriesNotFavourites = Dictionary(uniqueKeysWithValues: self.favouriteSeries.map { key, value in (key, false) })
        self.favouriteSeries = allSeriesNotFavourites
    }
    
    func setNoNotified() {
        let allSeriesNoNotifications = Dictionary(uniqueKeysWithValues: self.notificationSeries.map { key, value in (key, false) })
        self.notificationSeries = allSeriesNoNotifications
    }
    
} // CONTROLER

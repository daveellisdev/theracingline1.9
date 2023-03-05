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

    let productIDs = ["dev.daveellis.theracingline.coffee",
                      "dev.daveellis.theracingline.bronze",
                      "dev.daveellis.theracingline.silver",
                      "dev.daveellis.theracingline.gold",
                      "dev.daveellis.theracingline.annual"]
        
    static var shared = DataController()
    
    @ObservedObject var nc = NotificationController.shared
    @Published var storeManager = StoreManager()
    
    // MARK: - INIT
    init() {
        
        // load saved settings
        loadSavedSettings()
        
        // load payment information
        SKPaymentQueue.default().add(storeManager)
        storeManager.getProducts(productIDs: productIDs)
        self.applicationSavedSettings.subscribed = storeManager.restoreSubscriptionStatus()
                
        // load previously downloaded json
        loadSeriesAndSessionData()
        
        // download new json
        downloadData()
        
    }
    
    // MARK: - SERIES
    @Published var seriesUnfiltered: [Series] = []
    
    var series: [Series] {
        return self.seriesUnfiltered.filter { self.checkSessionSetting(type: .visible, seriesId: $0.seriesInfo.id) }
    }
    var seriesSingleSeater: [Series] {
        return self.seriesUnfiltered.filter { $0.seriesInfo.type == "Single Seater"}
    }
    var seriesSportscars: [Series] {
        return self.seriesUnfiltered.filter { $0.seriesInfo.type == "Sportscars"}
    }
    var seriesTouringcars: [Series] {
        return self.seriesUnfiltered.filter { $0.seriesInfo.type == "Touring Cars"}
    }
    var seriesStockcars: [Series] {
        return self.seriesUnfiltered.filter { $0.seriesInfo.type == "Stock Cars"}
    }
    var seriesRally: [Series] {
        return self.seriesUnfiltered.filter { $0.seriesInfo.type == "Rally"}
    }
    var seriesBikes: [Series] {
        return self.seriesUnfiltered.filter { $0.seriesInfo.type == "Bikes"}
    }
    var seriesOther: [Series] {
        return self.seriesUnfiltered.filter { $0.seriesInfo.type == "Other"}
    }
    
    // MARK: - CIRCUITS
    @Published var circuits: [Circuit] = []
    
    // MARK: - EVENTS
    @Published var events: [RaceEvent] = []
    var eventsInProgress: [RaceEvent] {
        return self.events.filter {
            if $0.eventInProgress() != nil && $0.eventInProgress()! {
                return true
            } else {
                return false
            }
        ;}
    }
    var eventsInProgressAndUpcoming: [RaceEvent] {
        return self.events.filter { !$0.eventComplete() }
    }
    
    // MARK: - SESSIONS

    @Published var unfilteredSessions: [Session] = []
    
    // SESSIONS VISIBLE
    var sessions: [Session] {
        return self.unfilteredSessions.filter { self.checkSessionSetting(type: .visible, seriesId: $0.seriesId) }
    }
    var sessionsInProgressAndUpcoming: [Session] {
        return self.sessions.filter { !$0.isComplete() }
    }
    var sessionsUpcomingButNotInProgress: [Session] {
        return self.sessions.filter { !$0.isComplete() && !$0.isInProgress() }
    }
    var sessionsUpcomingButNotInTheNextTwelveHours: [Session] {
        let twelveHoursAway = Date() + 12.hours
        
        return self.sessions.filter { !$0.isComplete() && !$0.isInProgress() && $0.raceStartTime() > twelveHoursAway }
    }
    var sessionsNextTenUpcomingButNotInProgress: [Session] {
        return Array(self.sessionsUpcomingButNotInProgress.prefix(10))
    }
    var sessionsNextTenUpcomingButNotInTheNextTwelveHours: [Session] {
        return Array(self.sessionsUpcomingButNotInTheNextTwelveHours.prefix(10))
    }
    
    var liveSessions: [Session] {
        return self.sessions.filter { $0.isInProgress() }
    }
    var sessionsWithinNextTwelveHours: [Session] {
        let now = Date()
        let twelveHoursAway = Date() + 12.hours
        
        return self.sessions.filter { $0.isInProgress() || ($0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now) }
    }
    var sessionsWithinNextTwelveHoursButNotLive: [Session] {
        let now = Date()
        let twelveHoursAway = Date() + 12.hours
        
        return self.sessions.filter { $0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now }
    }
    
    // favourite filtered
    var favouriteSessions: [Session] {
        return self.sessions.filter { self.checkSessionSetting(type: .favourite, seriesId: $0.seriesId) }
    }
    var favouriteSessionsInProgressAndUpcoming: [Session] {
        return self.favouriteSessions.filter { !$0.isComplete() }
    }
    var favouriteSessionsUpcomingButNotInProgress: [Session] {
        return self.favouriteSessions.filter { !$0.isComplete() && !$0.isInProgress() }
    }
    var favouriteSessionsUpcomingButNotInTheNextTwelveHours: [Session] {
        let twelveHoursAway = Date() + 12.hours
        
        return self.favouriteSessions.filter { !$0.isComplete() && !$0.isInProgress() && $0.raceStartTime() > twelveHoursAway }
    }
    var favouriteSessionsNextTenUpcomingButNotInProgress: [Session] {
        return Array(self.favouriteSessionsUpcomingButNotInProgress.prefix(10))
    }
    var favouriteSessionsNextTenUpcomingButNotInTheNextTwelveHours: [Session] {
        return Array(self.favouriteSessionsUpcomingButNotInTheNextTwelveHours.prefix(10))
    }
    var favouriteLiveSessions: [Session] {
        return self.favouriteSessions.filter { $0.isInProgress() }
    }
    var favouriteSessionsWithinNextTwelveHours: [Session] {
        let now = Date()
        let twelveHoursAway = Date() + 12.hours
        
        return self.favouriteSessions.filter { $0.isInProgress() || ($0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now) } .reversed()
    }
    var favouriteSessionsWithinNextTwelveHoursButNotLive: [Session] {
        let now = Date()
        let twelveHoursAway = Date() + 12.hours
        
        return self.favouriteSessions.filter { $0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now }
    }
    
    @Published var seriesSavedSettings: [SeriesSavedData] = []
    @Published var applicationSavedSettings: ApplicationSavedSettings = ApplicationSavedSettings(raceNotifications: true, qualifyingNotifications: false, practiceNotifications: false, testingNotifications: false, notificationOffset: 900, notificationSound: "1", subscribed: false)
    

    
    var timeLineHeight: CGFloat {
        return CGFloat((sessionsWithinNextTwelveHours.count * 50) - 20)
    }
    
    // MARK: - DOWNLOAD DATA
    
    func downloadData() {
//        print("Downloading Data")
        
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
            
            // initiate settings check
            self.initSavedSettings(data: data)
            
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

                // series
                self.seriesUnfiltered = json.series
//                print("Series Done")
                
                // circuits
                self.circuits = json.circuits
//                print("Circuits Done")
                
                // events
                var sortedEvents = json.events
                sortedEvents.sort {$0.firstRaceDate() < $1.firstRaceDate()}
                self.events = sortedEvents
//                print("Events Done")
                
                // sessions
                var sortedSessions = self.createSessions(events: self.events)
                sortedSessions.sort{ $0.raceStartTime() < $1.raceStartTime()}
                self.unfilteredSessions = sortedSessions
//                print("Sessions Done")
                
//                print("Decoding Finished")

                self.nc.initiateNotifications()
//                print("Initiating Notifications")
                
                self.saveSeriesAndSessionData(data: data)
            } // dispatchqueue
        } catch let jsonError as NSError {
            print(jsonError)
            print(jsonError.underlyingErrors)
            print(jsonError.localizedDescription)
        } // do catch
    }
    
    // MARK: - LOAD SERIES DATA
    
    func loadSeriesAndSessionData() {
//        print("Loading previous data")
        DispatchQueue.global().async {
            
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
                
                if let data = defaults.data(forKey: "seriesAndSessionData") {
                    DispatchQueue.main.async{
                        self.decodeData(data: data)
                    }
//                    print("Loaded Series Data")
                } // if let data
            } // if let defaults
        } // dispatchqueee
    }
    
    // MARK: - SAVE SERIES DATA
    
    func saveSeriesAndSessionData(data: Data) {
//        print("Saving Data")
        DispatchQueue.global().async {
            
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {

                defaults.set(data, forKey: "seriesAndSessionData")
                defaults.synchronize() // MAYBE DO NOT NEED
                
//                print("Saved Series Data")
            } // if let defaults
        } // dispatch queue
    }

    // MARK: - INITIALISE SAVED SETTINGS
    
    func initSavedSettings(data: Data) {
        
        // if no saved settings exist, then create it
        let decoder = JSONDecoder()

        if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
            
            // decode the downloaded data
            if let fullDataDownload = try? decoder.decode(FullDataDownload.self.self, from: data) {
                let seriesList = fullDataDownload.series
            
                // if exists, then fetch it
                if let settings = defaults.data(forKey: "savedSeriesSettings") {
                    
                    // decode the savedData
                    if var seriesSavedSettings = try? decoder.decode([SeriesSavedData].self, from: settings) {
                        
                        // check if saved data contains all series
                        for series in seriesList {
                            let seriesId = series.seriesInfo.id
                            
                            let savedSeriesMatch = seriesSavedSettings.filter {$0.seriesInfo.id == seriesId}
                            
                            // none found, add series
                            if savedSeriesMatch.count == 0 {
                                let newSavedSeries: SeriesSavedData = SeriesSavedData(seriesInfo: series.seriesInfo, visible: true, favourite: true, notifications: true)
                                seriesSavedSettings.append(newSavedSeries)
                            } // if
                        } // for loop
                                                
                        // publish updated settings
                        DispatchQueue.main.async {
                            self.seriesSavedSettings = seriesSavedSettings
                        }
                        
                    } // if var seriesSavedSettings
                } else { // try decoding settings
                    // if settings does not exist

                    var seriesSavedSettings: [SeriesSavedData] = []
                    
                    for series in seriesList {
                        let newSavedSeries: SeriesSavedData = SeriesSavedData(seriesInfo: series.seriesInfo, visible: true, favourite: true, notifications: true)
                        seriesSavedSettings.append(newSavedSeries)
                    }
                    
                    // publish updated settings
                    DispatchQueue.main.async {
                        self.seriesSavedSettings = seriesSavedSettings
                    }
                } // else create settings
            } // try decoding full data
            
            // Notifications - Offset, Sessions, Sound
            if defaults.data(forKey: "applicationSavedSettings") == nil {
                // if no saved settings, create defaults
                let defaultSettings = ApplicationSavedSettings(raceNotifications: true, qualifyingNotifications: false, practiceNotifications: false, testingNotifications: false, notificationOffset: 900, notificationSound: "flyby_notification_no_bell.aiff", subscribed: false)
                DispatchQueue.main.async {
                    self.applicationSavedSettings = defaultSettings
                }
            } // check for saved settings
            
            self.saveSavedSettings()

        } // if defaults exist
    } // init saved settings
    
    // MARK: - SAVING SAVED SETTINGS
    func saveSavedSettings() {
        DispatchQueue.global().async {
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(self.seriesSavedSettings) {
                    defaults.set(encoded, forKey: "savedSeriesSettings")
                }
                
                if let encoded = try? encoder.encode(self.applicationSavedSettings) {
                    defaults.set(encoded, forKey: "applicationSavedSettings")
                }
            }
        }
//        print("Saved Settings Run")
    }
    
    // MARK: - UPDATED SERIES SAVED SETTINGS
    
    func updatedSeriesSavedSettings(type: ToggleType, series: Series, newValue: Bool) {
        if var savedSeries = self.seriesSavedSettings.first(where: {$0.seriesInfo.id == series.seriesInfo.id}) {
            
            switch type {
            case .visible:
                savedSeries.visible = newValue
                if !newValue {
                    savedSeries.favourite = newValue
                }
            case .favourite:
                savedSeries.favourite = newValue
                if newValue {
                    savedSeries.visible = newValue
                }
            case .notification:
                savedSeries.notifications = newValue
            }
            
            if let index = self.seriesSavedSettings.firstIndex(where: {$0.seriesInfo.id == series.seriesInfo.id}) {
                self.seriesSavedSettings[index] = savedSeries
            }
        }
    }
    
    // MARK: - LOADING SAVED SETTINGS
    func loadSavedSettings() {
        DispatchQueue.global().async {
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
                let decoder = JSONDecoder()

                if let data = defaults.data(forKey: "savedSeriesSettings") {
                    if let seriesSavedSettings = try? decoder.decode([SeriesSavedData].self, from: data){
                        DispatchQueue.main.async{
                            self.seriesSavedSettings = seriesSavedSettings
//                            print("Loaded Saved Series Settings")
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
                }
            } // if let defaults
        } // dispatchqueee
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
        
        if let savedSeries = seriesSavedSettings.first(where: {$0.seriesInfo.id == seriesId}) {
            switch type {
            case .visible:
                return savedSeries.visible
            case .favourite:
                return savedSeries.favourite
            case .notification:
                return savedSeries.notifications
            }
        }

        return true
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

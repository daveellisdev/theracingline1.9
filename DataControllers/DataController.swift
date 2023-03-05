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
    
//    @Published var storeManager = StoreManager()
    
    @Published var seriesUnfiltered: [Series] = []
    @Published var series: [Series] = []
    @Published var seriesSingleSeater: [Series] = []
    @Published var seriesSportscars: [Series] = []
    @Published var seriesTouringcars: [Series] = []
    @Published var seriesStockcars: [Series] = []
    @Published var seriesRally: [Series] = []
    @Published var seriesBikes: [Series] = []
    @Published var seriesOther: [Series] = []
    
    @Published var circuits: [Circuit] = []
    
    @Published var events: [RaceEvent] = []
    @Published var eventsInProgress: [RaceEvent] = []
    @Published var eventsInProgressAndUpcoming: [RaceEvent] = []

    @Published var unfilteredSessions: [Session] = []
    // visible filtered
    @Published var sessions: [Session] = []
    @Published var sessionsUpcomingButNotInProgress: [Session] = []
    @Published var sessionsUpcomingButNotInTheNextTwelveHours: [Session] = []
    @Published var sessionsNextTenUpcomingButNotInProgress: [Session] = []
    @Published var sessionsNextTenUpcomingButNotInTheNextTwelveHours: [Session] = []
    @Published var sessionsInProgressAndUpcoming: [Session] = []
    @Published var liveSessions: [Session] = []
    @Published var sessionsWithinNextTwelveHours: [Session] = []
    @Published var sessionsWithinNextTwelveHoursButNotLive: [Session] = []
    
    // favourite filtered
    @Published var favouriteSessions: [Session] = []
    @Published var favouriteSessionsUpcomingButNotInProgress: [Session] = []
    @Published var favouriteSessionsUpcomingButNotInTheNextTwelveHours: [Session] = []
    @Published var favouriteSessionsNextTenUpcomingButNotInProgress: [Session] = []
    @Published var favouriteSessionsNextTenUpcomingButNotInTheNextTwelveHours: [Session] = []
    @Published var favouriteSessionsInProgressAndUpcoming: [Session] = []
    @Published var favouriteLiveSessions: [Session] = []
    @Published var favouriteSessionsWithinNextTwelveHours: [Session] = []
    @Published var favouriteSessionsWithinNextTwelveHoursButNotLive: [Session] = []
    
    @Published var seriesSavedSettings: [SeriesSavedData] = []
    @Published var applicationSavedSettings: ApplicationSavedSettings = ApplicationSavedSettings(raceNotifications: true, qualifyingNotifications: false, practiceNotifications: false, testingNotifications: false, notificationOffset: 900, notificationSound: "1", subscribed: false)
    
    init() {
//        SKPaymentQueue.default().add(storeManager)
//        storeManager.getProducts(productIDs: productIDs)
//        self.applicationSavedSettings.subscribed = storeManager.restoreSubscriptionStatus()
        
        // load user saved settings
        
        // load previously downloaded json
        loadSeriesAndSessionData()
        loadSavedSettings()
        
        // download new json
        downloadData()
        
    }
    
    var timeLineHeight: CGFloat {
        return CGFloat((sessionsWithinNextTwelveHours.count * 50) - 20)
    }
    
    // MARK: - DOWNLOAD DATA
    
    func downloadData() {
        print("Downloading Data")
        
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
                
                let now = Date()
                let twelveHoursAway = Date() + 12.hours

                // series
                self.seriesUnfiltered = json.series
                self.series = self.seriesUnfiltered.filter { self.checkSessionSetting(type: .visible, seriesId: $0.seriesInfo.id) }
                self.seriesSingleSeater = self.seriesUnfiltered.filter { $0.seriesInfo.type == "Single Seater"}
                self.seriesSportscars = self.seriesUnfiltered.filter { $0.seriesInfo.type == "Sportscars"}
                self.seriesTouringcars = self.seriesUnfiltered.filter { $0.seriesInfo.type == "Touring Cars"}
                self.seriesStockcars = self.seriesUnfiltered.filter { $0.seriesInfo.type == "Stock Cars"}
                self.seriesRally = self.seriesUnfiltered.filter { $0.seriesInfo.type == "Rally"}
                self.seriesBikes = self.seriesUnfiltered.filter { $0.seriesInfo.type == "Bikes"}
                self.seriesOther = self.seriesUnfiltered.filter { $0.seriesInfo.type == "Other"}
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
                // visible sessions
                self.sessions = sortedSessions.filter { self.checkSessionSetting(type: .visible, seriesId: $0.seriesId) }
                self.sessionsInProgressAndUpcoming = sortedSessions.filter { !$0.isComplete() && self.checkSessionSetting(type: .visible, seriesId: $0.seriesId) }
                self.sessionsUpcomingButNotInProgress = sortedSessions.filter { !$0.isComplete() && !$0.isInProgress() && self.checkSessionSetting(type: .visible, seriesId: $0.seriesId) }
                self.sessionsUpcomingButNotInTheNextTwelveHours = sortedSessions.filter { !$0.isComplete() && !$0.isInProgress() && $0.raceStartTime() > twelveHoursAway && self.checkSessionSetting(type: .visible, seriesId: $0.seriesId) }

                self.sessionsNextTenUpcomingButNotInProgress = Array(self.sessionsUpcomingButNotInProgress.prefix(10))
                self.sessionsNextTenUpcomingButNotInTheNextTwelveHours = Array(self.sessionsUpcomingButNotInTheNextTwelveHours.prefix(10))


                self.liveSessions = sortedSessions.filter { $0.isInProgress() && self.checkSessionSetting(type: .visible, seriesId: $0.seriesId) }
                self.sessionsWithinNextTwelveHours = sortedSessions.filter { $0.isInProgress() || ($0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now) && self.checkSessionSetting(type: .visible, seriesId: $0.seriesId) }
                self.sessionsWithinNextTwelveHours.reverse()
                self.sessionsWithinNextTwelveHoursButNotLive = sortedSessions.filter { $0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now && self.checkSessionSetting(type: .visible, seriesId: $0.seriesId) }
                
                // favourite filtered
                self.favouriteSessions = sortedSessions.filter { self.checkSessionSetting(type: .favourite, seriesId: $0.seriesId) }
                self.favouriteSessionsInProgressAndUpcoming = sortedSessions.filter { !$0.isComplete() && self.checkSessionSetting(type: .favourite, seriesId: $0.seriesId) }
                self.favouriteSessionsUpcomingButNotInProgress = sortedSessions.filter { !$0.isComplete() && !$0.isInProgress() && self.checkSessionSetting(type: .favourite, seriesId: $0.seriesId) }
                self.favouriteSessionsUpcomingButNotInTheNextTwelveHours = sortedSessions.filter { !$0.isComplete() && !$0.isInProgress() && $0.raceStartTime() > twelveHoursAway && self.checkSessionSetting(type: .favourite, seriesId: $0.seriesId) }

                self.favouriteSessionsNextTenUpcomingButNotInProgress = Array(self.favouriteSessionsUpcomingButNotInProgress.prefix(10))
                self.favouriteSessionsNextTenUpcomingButNotInTheNextTwelveHours = Array(self.favouriteSessionsUpcomingButNotInTheNextTwelveHours.prefix(10))


                self.favouriteLiveSessions = sortedSessions.filter { $0.isInProgress() && self.checkSessionSetting(type: .favourite, seriesId: $0.seriesId) }
                self.favouriteSessionsWithinNextTwelveHours = sortedSessions.filter { $0.isInProgress() || ($0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now) && self.checkSessionSetting(type: .favourite, seriesId: $0.seriesId) }
                self.favouriteSessionsWithinNextTwelveHours.reverse()
                self.favouriteSessionsWithinNextTwelveHoursButNotLive = sortedSessions.filter { $0.raceStartTime() < twelveHoursAway && $0.raceStartTime() > now && self.checkSessionSetting(type: .favourite, seriesId: $0.seriesId) }
                
                print("Sessions Done")
                print("Decoding Finished")

                self.nc.initiateNotifications()
                print("Initiating Notifications")
                
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
        print("Loading previous data")
        DispatchQueue.global().async {
            
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
                
                if let data = defaults.data(forKey: "seriesAndSessionData") {
                    DispatchQueue.main.async{
                        self.decodeData(data: data)
                    }
                    print("Loaded Series Data")
                } // if let data
            } // if let defaults
        } // dispatchqueee
    }
    
    // MARK: - SAVE SERIES DATA
    
    func saveSeriesAndSessionData(data: Data) {
        print("Saving Data")
        DispatchQueue.global().async {
            
            if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {

                defaults.set(data, forKey: "seriesAndSessionData")
                defaults.synchronize() // MAYBE DO NOT NEED
                
                print("Saved Series Data")
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
        print("Saved Settings Run")
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
                            print("Loaded Saved Series Settings")
                        }
                    }
                    
                } // if let data
                
                if let data = defaults.data(forKey: "applicationSavedSettings") {
                    if let applicationSavedSettings = try? decoder.decode(ApplicationSavedSettings.self, from: data) {
                        DispatchQueue.main.async {
                            self.applicationSavedSettings = applicationSavedSettings
                            print("Loaded Application Saved Settings")
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

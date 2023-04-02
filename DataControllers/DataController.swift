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
    @Published var seriesUnfiltered: [Series] = []
    
    @Published var visibleSeries: [String:Bool] = [:]
    @Published var favouriteSeries: [String:Bool] = [:]
    @Published var notificationSeries: [String:Bool] = [:]
    
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
        return self.sessions.filter { !$0.isComplete() }
    }
    var liveSessions: [Session] {
        return self.sessions.filter { $0.isInProgress() }
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
    var notificationSessions: [Session] {
        unfilteredSessions.filter {
            let now = Date()
            let twoWeeks = Date()+4.weeks
            return $0.raceStartTime() < twoWeeks && $0.raceStartTime() > now
        }
    }
    
    // weekly sessions for dashboard
    var mondayFavouriteSessions: [Session] {
        
        let seconds = TimeZone.current.secondsFromGMT()
        let minutesToGMT = (seconds / 60) + (seconds % 60)
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        let mondayDateObject: Date
        
        if weekday == 2 {
            mondayDateObject = Date()
        } else {
            mondayDateObject = Date().dateAt(.nextWeekday(.monday))
        }
                
        let mondayStart = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: mondayDateObject)! + minutesToGMT.minutes
        let mondayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: mondayDateObject)! + minutesToGMT.minutes  + 4.hours + 30.minutes
        
        return self.favouriteSessions.filter { $0.raceStartTime() > mondayStart && $0.raceStartTime() < mondayEnd }
    }
    
    var tuesdayFavouriteSessions: [Session] {
        
        let seconds = TimeZone.current.secondsFromGMT()
        let minutesToGMT = (seconds / 60) + (seconds % 60)
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        let tuesdayDateObject: Date
        
        if weekday == 3 {
            tuesdayDateObject = Date()
        } else {
            tuesdayDateObject = Date().dateAt(.nextWeekday(.tuesday))
        }
                
        let tuesdayStart = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: tuesdayDateObject)! + minutesToGMT.minutes
        let tuesdayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: tuesdayDateObject)! + minutesToGMT.minutes  + 4.hours + 30.minutes
        
        return self.favouriteSessions.filter { $0.raceStartTime() > tuesdayStart && $0.raceStartTime() < tuesdayEnd }
    }
    
    var wednesdayFavouriteSessions: [Session] {
        
        let seconds = TimeZone.current.secondsFromGMT()
        let minutesToGMT = (seconds / 60) + (seconds % 60)
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        let wednesdayDateObject: Date
        
        if weekday == 4 {
            wednesdayDateObject = Date()
        } else {
            wednesdayDateObject = Date().dateAt(.nextWeekday(.wednesday))
        }
                
        let wednesdayStart = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: wednesdayDateObject)! + minutesToGMT.minutes
        let wednesdayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: wednesdayDateObject)! + minutesToGMT.minutes  + 4.hours + 30.minutes
        
        return self.favouriteSessions.filter { $0.raceStartTime() > wednesdayStart && $0.raceStartTime() < wednesdayEnd }
    }
    
    var thursdayFavouriteSessions: [Session] {
        
        let seconds = TimeZone.current.secondsFromGMT()
        let minutesToGMT = (seconds / 60) + (seconds % 60)
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        let thursdayDateObject: Date

        if weekday == 5 {
            thursdayDateObject = Date()
        } else {
            thursdayDateObject = Date().dateAt(.nextWeekday(.thursday))
        }
                
        let thursdayStart = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: thursdayDateObject)! + minutesToGMT.minutes
        let thursdayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: thursdayDateObject)! + minutesToGMT.minutes  + 4.hours + 30.minutes
        
        return self.favouriteSessions.filter { $0.raceStartTime() > thursdayStart && $0.raceStartTime() < thursdayEnd }
    }
    
    var fridayFavouriteSessions: [Session] {
        
        let seconds = TimeZone.current.secondsFromGMT()
        let minutesToGMT = (seconds / 60) + (seconds % 60)
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        let fridayDateObject: Date
        
        if weekday == 6 {
            fridayDateObject = Date()
        } else {
            fridayDateObject = Date().dateAt(.nextWeekday(.friday))
        }
                
        let fridayStart = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: fridayDateObject)! + minutesToGMT.minutes
        let fridayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: fridayDateObject)! + minutesToGMT.minutes  + 4.hours + 30.minutes
        
        return self.favouriteSessions.filter { $0.raceStartTime() > fridayStart && $0.raceStartTime() < fridayEnd }
    }
    
    var saturdayFavouriteSessions: [Session] {
        
        let seconds = TimeZone.current.secondsFromGMT()
        let minutesToGMT = (seconds / 60) + (seconds % 60)
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        let saturdayDateObject: Date
        
        if weekday == 7 {
            saturdayDateObject = Date()
        } else {
            saturdayDateObject = Date().dateAt(.nextWeekday(.saturday))
        }
                
        let saturdayStart = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: saturdayDateObject)! + minutesToGMT.minutes
        let saturdayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: saturdayDateObject)! + minutesToGMT.minutes  + 4.hours + 30.minutes
        
        return self.favouriteSessions.filter { $0.raceStartTime() > saturdayStart && $0.raceStartTime() < saturdayEnd }
    }
    
    var sundayFavouriteSessions: [Session] {
        
        let seconds = TimeZone.current.secondsFromGMT()
        let minutesToGMT = (seconds / 60) + (seconds % 60)
        
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        let sundayDateObject: Date
        
        if weekday == 1 {
            sundayDateObject = Date()
        } else {
            sundayDateObject = Date().dateAt(.nextWeekday(.sunday))
        }
                
        let sundayStart = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: sundayDateObject)! + minutesToGMT.minutes
        let sundayEnd = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: sundayDateObject)! + minutesToGMT.minutes  + 4.hours + 30.minutes
        
        return self.favouriteSessions.filter { $0.raceStartTime() > sundayStart && $0.raceStartTime() < sundayEnd }
    }
    
    @Published var seriesSavedSettings: [SeriesSavedData] = []
    @Published var applicationSavedSettings: ApplicationSavedSettings = ApplicationSavedSettings(raceNotifications: true, qualifyingNotifications: false, practiceNotifications: false, testingNotifications: false, notificationOffset: 900, notificationSound: "1")
    

    
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
            
            // initiate settings check
            self.initSavedSettings(data: data)
//            print("Data Downloaded Data \(Date())")
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
        print("Decoding Data \(Date())")

        do {
            let json = try JSONDecoder().decode(FullDataDownload.self, from: data)
            
            var sortedEvents = json.events
            sortedEvents.sort {$0.firstRaceDate() < $1.firstRaceDate()}
            
            var sortedSessions = self.createSessions(events: self.events)
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
                self.seriesUnfiltered = json.series
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
//                print("Data Decoded \(Date())")
                
                self.saveSeriesAndSessionData(data: data)
            } // dispatchqueue
        } catch let jsonError as NSError {
            print(jsonError)
            print(jsonError.underlyingErrors)
            print(jsonError.localizedDescription)
        } // do catch
        print("Decoding Data Completed \(Date())")
    }
    
    // MARK: - LOAD SERIES DATA
    
    func loadSeriesAndSessionData() {
//        print("Loading previous sessions \(Date())")
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
//        } // dispatchqueee
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
                let defaultSettings = ApplicationSavedSettings(raceNotifications: true, qualifyingNotifications: false, practiceNotifications: false, testingNotifications: false, notificationOffset: 900, notificationSound: "flyby_notification_no_bell.aiff")
                DispatchQueue.main.async {
                    self.applicationSavedSettings = defaultSettings
                }
            } // check for saved settings
            
            self.saveSavedSettings()

        } // if defaults exist
    } // init saved settings
    
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

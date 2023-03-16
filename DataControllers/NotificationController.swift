//
//  NotificationController.swift
//  theracingline
//
//  Created by Dave on 21/02/2023.
//

import Foundation
import UserNotifications
import SwiftDate
import SwiftUI

class NotificationController: ObservableObject {
    
    static var shared = NotificationController()
    
    @ObservedObject var dc = DataController.shared

    // MARK: - NOTIFICATION INIT
    func initiateNotifications() {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { permission in
            switch permission.authorizationStatus  {
            case .authorized:
//                print("User granted permission for notification")
                self.rebuildNotifications()
            case .denied:
                print("User denied notification permission")
            case .notDetermined:
                print("Notification permission haven't been asked yet")
                self.requestPermission()
            case .provisional:
                // @available(iOS 12.0, *)
                print("The application is authorized to post non-interruptive user notifications.")
            case .ephemeral:
                // @available(iOS 14.0, *)
                print("The application is temporarily authorized to post notifications. Only available to app clips.")
            @unknown default:
                print("Unknow Status")
            }
        })
    }
    
    // MARK: - PERMISSIONS REQUEST
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.rebuildNotifications()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - REBUILD NOTIFICATIONS
    
    func rebuildNotifications(){
        
        print("Rebuild notifications called")
        // get all sessions
        let fullSessionList = self.dc.notificationSessions
        let applicationSavedSettings = self.dc.applicationSavedSettings
        
//        let sessionListFilteredBySeries = fullSessionList.filter { self.dc.checkSessionSetting(type: .notification, seriesId: $0.seriesId) }

        // clear notifications
        self.clearNotifications()
        
        // Weekly Notification
        self.setReminderNotificaton()
        
        //filter sessions based on preferences
        //loop through remaining sessions and set notifications
        for (index, session) in fullSessionList.enumerated() {

            if index < 40 && (session.date.tba == nil || !session.date.tba!) {
                self.setNotifictions(session: session)
            }
        }
    }
    
    // MARK: - SET SESSION NOTIFICATION
    
    func setNotifictions(session: Session) {
        print("Notification setup for \(session.seriesId) - \(session.circuit.circuit) - \(session.session.sessionName)")
        let notificationSavedSettings = self.getSavedSettings()!
        let timeOffset = notificationSavedSettings.notificationOffset
        let currentDate = Date()

        let secondsBetweenNowAndRace = Int(currentDate.getInterval(toDate: session.raceStartTime(), component: .second))
        let secondsUntilNotification = secondsBetweenNowAndRace - timeOffset
        
        if secondsUntilNotification > 0 {
            let messageString = buildNotificationTimeString(session: session)
            if let series = getSeriesById(seriesId: session.seriesId) {
                let content = UNMutableNotificationContent()
                content.title = series.seriesInfo.name
                content.subtitle = "\(session.circuit.circuit) - \(session.session.sessionName)"
                content.body = messageString
                content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: notificationSavedSettings.notificationSound))
                if #available(iOS 15.0, *) {
                    content.interruptionLevel = .timeSensitive
                }

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secondsUntilNotification), repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                       print("Unable to add notification request, \(error.localizedDescription)")
                     }
                }
            }
        }
    }
    
    // MARK: - SET WEEKLY REMINDER
    func setReminderNotificaton() {
        let content = UNMutableNotificationContent()
        content.title = "See What's On This Week"
        content.body = "Open the app once a week to update race data and start time notifications"
        
        // add 5 days to current date
        let today = Date()
        let fiveDays = today + 5.days
        let todayCalendar = Calendar.current
        
        let fiveDayComponent = todayCalendar.component(.weekday, from: fiveDays)
        let hourComponent = todayCalendar.component(.hour, from: fiveDays)
        let minuteComponent = todayCalendar.component(.minute, from: fiveDays)

        // create date for notification
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = fiveDayComponent
        dateComponents.hour = hourComponent
        dateComponents.minute = minuteComponent

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
               print("Failed creating weekly reminder")
           }
        }
    }
    
    // MARK: - CLEAR NOTIFICATIONS
    func clearNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    // MARK: - BUILD STRING
    func buildNotificationTimeString(session: Session) -> String {
        
        var daysString = ""
        var hoursString = ""
        var minutesString = ""
        
        let applicationSavedSettings = self.getSavedSettings()!
        let notificationTime = self.getNotificationTime(savedSettings: applicationSavedSettings)
        
        let days = notificationTime.days
        let hours = notificationTime.hours
        let minutes = notificationTime.minutes
        
        if session.duration.durationTypeEnum == .allDay {
            if days < 1 {
                return "Event begins today"
            } else if days < 2 {
                return "Event begins tomorrow"
            } else {
                return "Event begins in \(days) days."
            }
        }
        
        if days != 0 {
            if days == 1 {
                daysString = "\(days) day "
            } else {
                daysString = "\(days) days "
            }
        }
        
        if hours != 0 {
            if hours == 1 {
                hoursString = "\(hours) hour "
            } else {
                hoursString = "\(hours) hours "
            }
        }
        
        if minutes != 0 {
            if minutes == 1 {
                minutesString = "\(minutes) minute "
            } else {
                minutesString = "\(minutes) minutes "
            }
        }
        
        var messageString = "Unkown"
        
        if days == 0 && hours == 0 && minutes == 0 {
            messageString = "Event beginning now"
        } else {
            messageString = "Event begins in \(daysString)\(hoursString)\(minutesString)"
        }
            
        return messageString
    }
    
    // MARK: - GET NOTIFICATION TIME
    func getNotificationTime(savedSettings: ApplicationSavedSettings) -> NotificationOffset {
        
        let fullTimeInSeconds = savedSettings.notificationOffset
        
        let days = (fullTimeInSeconds / 86400)
        let hours = (fullTimeInSeconds % 86400) / 3600
        let minutes = ((fullTimeInSeconds % 86400) % 3600) / 60
//        print(days, hours, minutes)
        let notificationOffset = NotificationOffset(days: days, hours: hours, minutes: minutes)
        
        return notificationOffset
        
    }
    func getSavedSettings() -> ApplicationSavedSettings? {
        
        if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
            let decoder = JSONDecoder()
            
            if let data = defaults.data(forKey: "applicationSavedSettings") {
                if let applicationSavedSettings = try? decoder.decode(ApplicationSavedSettings.self, from: data) {
                    return applicationSavedSettings
                }
            }
        }
        
        return nil
    }
    
    func getSeriesSavedSettings() -> [SeriesSavedData]? {
        
        if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
            let decoder = JSONDecoder()

            if let data = defaults.data(forKey: "savedSeriesSettings") {
                if let seriesSavedSettings = try? decoder.decode([SeriesSavedData].self, from: data){
                    return seriesSavedSettings
                }
            }
        }
        
        return nil
    }
    
    // MARK: - GET SESSION LIST
    func getSessionList() -> [Session]? {
        if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
            
            if let data = defaults.data(forKey: "seriesAndSessionData") {
                do {
                    let json = try JSONDecoder().decode(FullDataDownload.self, from: data)
                    var sessions = self.createSessions(events: json.events)
                    sessions.sort { $0.raceStartTime() < $1.raceStartTime()}
                    return sessions
                } catch let jsonError as NSError {
                    print(jsonError)
                    print(jsonError.underlyingErrors)
                    print(jsonError.localizedDescription)
                }
                
            } // if let data
        } // if let defaults
        
        return nil
    }
    
    // MARK: - FILTER SERIES BY PREFERENCES
    func filterSeriesByPreferences(unfilteredSessions: [Session]) -> [Session] {
        
        let seriesSavedSettings = self.getSeriesSavedSettings()!
        let applicationSavedSettings = self.getSavedSettings()!
        
         
        let filteredBySessionType = unfilteredSessions.filter {
            // filter by session types
            if ($0.session.sessionTypeEnum == .testing && !applicationSavedSettings.testingNotifications) || ($0.session.sessionTypeEnum == .practice && !applicationSavedSettings.practiceNotifications) || ($0.session.sessionTypeEnum == .qualifying && !applicationSavedSettings.qualifyingNotifications) || ($0.session.sessionTypeEnum == .race && !applicationSavedSettings.raceNotifications) {
                return false
            } else {
                return true
            }
        }
        
        var filteredBySeries: [Session] = []
        
        for session in filteredBySessionType {
            
            // find series saved settings
            if let seriesSavedSetting = seriesSavedSettings.first(where: {$0.seriesInfo.id == session.seriesId}) {
                if seriesSavedSetting.notifications {
                    filteredBySeries.append(session)
                }
            } else {
                filteredBySeries.append(session)
            }
            
        }
        
        let now = Date()
        let filteredByDate: [Session] = filteredBySeries.filter { $0.raceStartTime() > now }
    
        return filteredByDate
    }
    
    func createSessions(events: [RaceEvent]) -> [Session] {

        var sessions: [Session] = []
        for event in events {
            sessions.append(contentsOf: event.sessions)
        }
        sessions.sort { $0.raceStartTime() < $1.raceStartTime() }
        
        return sessions
    }
    
    func getSeriesById(seriesId: String) -> Series? {
        if let defaults = UserDefaults(suiteName: "group.dev.daveellis.theracingline") {
            
            if let data = defaults.data(forKey: "seriesAndSessionData") {
                do {
                    let json = try JSONDecoder().decode(FullDataDownload.self, from: data)
                    let series = json.series
                    
                    if let index = series.firstIndex(where: {$0.seriesInfo.id == seriesId}) {
                        return series[index]
                    } else {
                        return nil
                    }
                    
                } catch let jsonError as NSError {
                    print(jsonError)
                    print(jsonError.underlyingErrors)
                    print(jsonError.localizedDescription)
                }
                
            } // if let data
        } // if let defaults
        
        return nil
    }
}

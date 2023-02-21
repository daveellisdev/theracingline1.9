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
        
        // get all sessions
        let fullSessionList = dc.unfilteredSessions

        // clear notifications
        clearNotifications()
        
        // Weekly Notification
        setReminderNotificaton()
        
        //filter sessions based on preferences
        let sessionsFilteredByNotifications = filterSeriesByPreferences(unfilteredSessions: fullSessionList)
        
        //loop through remaining sessions and set notifications
        for (index, session) in sessionsFilteredByNotifications.enumerated() {
            if index < 40 && (session.date.tba != nil && !session.date.tba!) {
                setNotifictions(session: session)
            }
        }
    }
    
    // MARK: - SET SESSION NOTIFICATION
    
    func setNotifictions(session: Session) {
        
        let timeOffset = dc.applicationSavedSettings.notificationOffset
        let currentDate = Date()

        let secondsBetweenNowAndRace = Int(currentDate.getInterval(toDate: session.raceStartTime(), component: .second))
        let secondsUntilNotification = secondsBetweenNowAndRace - timeOffset
        
        if secondsUntilNotification > 0 {
            let messageString = buildNotificationTimeString(session: session)
            
            let content = UNMutableNotificationContent()
            content.title = session.series
            content.subtitle = "\(session.circuit.circuit) - \(session.session.sessionName)"
            content.body = messageString
            content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: dc.applicationSavedSettings.notificationSound))
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
        
        let notificationTime = getNotificationTime()
        
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
    func getNotificationTime() -> NotificationOffset {
        let notificiationOffset = dc.loadNotificationOffset()
         return notificiationOffset
    }
    
    // MARK: - FILTER SERIES BY PREFERENCES
    func filterSeriesByPreferences(unfilteredSessions: [Session]) -> [Session] {
        
        let seriesSavedSettings = dc.seriesSavedSettings
        let applicationSavedSettings = dc.applicationSavedSettings
        
        
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
        return filteredBySessionType
    }
}

//
//  ApplicationSavedSettings.swift
//  theracingline
//
//  Created by Dave on 12/02/2023.
//

import Foundation

struct ApplicationSavedSettings: Decodable, Encodable, Equatable {
    var raceNotifications: Bool
    var qualifyingNotifications: Bool
    var practiceNotifications: Bool
    var testingNotifications: Bool
    var notificationOffset: Int
    var notificationSound: String
}

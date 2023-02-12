//
//  ApplicationSavedSettings.swift
//  theracingline
//
//  Created by Dave on 12/02/2023.
//

import Foundation

struct ApplicationSavedSettings: Decodable, Encodable {
    let raceNotifications: Bool
    let qualifyingNotifications: Bool
    let practiceNotifications: Bool
    let notificationOffset: Int
    let notificationSound: String
}

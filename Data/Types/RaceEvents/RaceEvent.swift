//
//  RaceEvent.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct RaceEvent: Codable, Identifiable {
    let id = UUID()
    let eventId: Int
    let eventName: String
    let sessions: [Session]
}

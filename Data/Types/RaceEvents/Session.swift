//
//  Session.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct Session: Codable, Identifiable {
    let id: Int
    let seriesId: String
    let circuit: CircuitInfo
    let session: SessionInfo
    let date: SessionDate
    let duration: Duration?
}

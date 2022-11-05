//
//  SessionInfo.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct SessionInfo: Codable {
    let sessionName: String
    let sessionType: String
}

let exampleSessionInfo = SessionInfo(sessionName: "Race", sessionType: "R")
let exampleSessionInfo2 = SessionInfo(sessionName: "Qualifying", sessionType: "Q")

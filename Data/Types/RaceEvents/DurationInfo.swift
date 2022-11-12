//
//  DurationInfo.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct Duration: Codable {
    let durationType: String
    let duration: Int
    let tba: Bool?
    let durationMinutes: Int
}


var exampleDuration = Duration(durationType: "R", duration: 67, tba: nil, durationMinutes: 90)
var exampleDuration2 = Duration(durationType: "R", duration: 52, tba: true, durationMinutes: 90)
var exampleDuration3 = Duration(durationType: "T", duration: 60, tba: true, durationMinutes: 60)


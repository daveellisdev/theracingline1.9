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
}


var exampleDuration = Duration(durationType: "R", duration: 67, tba: nil)
var exampleDuration2 = Duration(durationType: "R", duration: 52, tba: true)

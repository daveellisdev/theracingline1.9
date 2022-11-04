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

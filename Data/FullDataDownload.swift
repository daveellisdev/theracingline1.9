//
//  FullDataDownload.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct FullDataDownload: Codable {
    let series: [Series]
    let circuits: [Circuit]
    let events: [RaceEvent]
}

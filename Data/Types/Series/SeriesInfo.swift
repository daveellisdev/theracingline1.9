//
//  SeriesInfo.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct SeriesInfo: Codable, Identifiable {
    let id: String
    let name: String
    let shortName: String
    let type: String
}

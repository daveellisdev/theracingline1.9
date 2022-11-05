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

let exampleSeriesInfo = SeriesInfo(id: "f1", name: "Formula 1", shortName: "F1", type: "Single Seater")

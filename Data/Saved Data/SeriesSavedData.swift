//
//  SeriesSavedData.swift
//  theracingline
//
//  Created by Dave on 29/01/2023.
//

import Foundation

struct SeriesSavedData: Decodable, Encodable, Equatable {
    static func == (lhs: SeriesSavedData, rhs: SeriesSavedData) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    let seriesInfo: SeriesInfo
    var visible: Bool
    var favourite: Bool
    var notifications: Bool
    
}

//
//  SeriesList.swift
//  theracingline
//
//  Created by Dave on 29/12/2022.
//

import Foundation

struct SeriesList: Codable, Identifiable {
    
    let id = UUID()
    let seriesInfo: SeriesInfo
    let colourValues: ColourValues
    let links: Links
    let streaming: [Streaming]
    let events: [RaceEvent]
    
}

//
//  Series.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct Series: Codable, Identifiable, Hashable {
   
    let id = UUID()
    let seriesInfo: SeriesInfo
    let colourValues: ColourValues
    let links: Links
    let streaming: [Streaming]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Series, rhs: Series) -> Bool {
        lhs.id == rhs.id
    }
}

let exampleSeries = Series(seriesInfo: exampleSeriesInfo, colourValues: exampleColourValues, links: exampleLinks, streaming: [exampleStreaming, exampleStreaming2])

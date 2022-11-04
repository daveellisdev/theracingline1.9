//
//  Series.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct Series: Codable, Identifiable {
    let id = UUID()
    let seriesInfo: SeriesInfo
    let colourValues: ColourValues
    let links: Links
    let streaming: [Streaming]
}

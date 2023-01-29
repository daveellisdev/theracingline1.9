//
//  SeriesSavedData.swift
//  theracingline
//
//  Created by Dave on 29/01/2023.
//

import Foundation

struct SeriesSavedData {
    
    let id = UUID()
    let seriesInfo: SeriesInfo
    let visible: Bool
    let favourite: Bool
    let notifications: Bool
    
}

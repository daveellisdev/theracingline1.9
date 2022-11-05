//
//  Streaming.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct Streaming: Codable {
    let id = UUID()
    let name: String
    let country: String
    let url: String
}

var exampleStreaming = Streaming(name: "F1TV", country: "🇪🇺🇺🇸", url: "https://f1tv.formula1.com/")
var exampleStreaming2 = Streaming(name: "SkySportsF1 - NowTV", country: "🇬🇧", url: "https://www.nowtv.com/")

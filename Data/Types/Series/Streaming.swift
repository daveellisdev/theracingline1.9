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

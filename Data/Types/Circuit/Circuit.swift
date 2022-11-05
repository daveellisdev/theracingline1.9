//
//  Circuit.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct Circuit: Codable  {
    let circuit: String
    let layout: String?
    let country: String
    let emoji: String
    let location: CircuitLocation
    let type: String
}

var exampleCircle = Circuit(circuit: "Silverstone", layout: "Grand Prix", country: "United Kingdom", emoji: "🇬🇧", location: exampleCircuitLocation, type: "circuit")

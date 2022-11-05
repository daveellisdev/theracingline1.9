//
//  CircuitInfo.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct CircuitInfo: Codable {
    let circuit: String
    let circuitLayout: String?
}

let exampleCircuitInfo = CircuitInfo(circuit: "Silverstone", circuitLayout: "Grand Prix")
let exampleCircuitInfo2 = CircuitInfo(circuit: "Knockhill", circuitLayout: nil)

//
//  CircuitLocation.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct CircuitLocation: Codable {
    let lat: Float
    let long: Float
}

var exampleCircuitLocation = CircuitLocation(lat: 52.071669, long: -1.016031)

//
//  DarkColour.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct ColourValues: Codable {
    let dark: [Int]
    let light: [Int]
}

var exampleColourValues = ColourValues(dark: [175, 34, 34], light: [237, 33, 58])
var exampleColourValues2 = ColourValues(dark: [22, 86, 150], light: [58, 123, 213])

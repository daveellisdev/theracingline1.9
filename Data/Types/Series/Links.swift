//
//  Links.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct Links: Codable {
    let official: String
    let timing: String
}

var exampleLinks = Links(official: "https://www.formula1.com/", timing: "https://www.formula1.com/en/f1-live.html")

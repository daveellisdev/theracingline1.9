//
//  SessionDate.swift
//  theracingline
//
//  Created by Dave on 04/11/2022.
//

import Foundation

struct SessionDate: Codable {
    let date: String
    let tba: Bool?
}

var exampleSessionDate = SessionDate(date: "Sat Apr 01 2023 04:00:00 GMT+0100 (British Summer Time)", tba: nil)
var exampleSessionDate2 = SessionDate(date: "Sat Apr 01 2023 08:00:00 GMT+0100 (British Summer Time)", tba: true)

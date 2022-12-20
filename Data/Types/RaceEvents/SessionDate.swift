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

var exampleSessionDate = SessionDate(date: "Tue Dec 20 2022 21:00:00 GMT+0100 (British Summer Time)", tba: nil)
var exampleSessionDate2 = SessionDate(date: "Tue Dec 20 2022 21:00:00 GMT+0100 (British Summer Time)", tba: true)
var exampleSessionDate3 = SessionDate(date: "Tue Dec 20 2022 21:00:00 GMT+0100 (British Summer Time)", tba: true)


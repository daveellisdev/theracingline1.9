//
//  Sounds.swift
//  theracingline
//
//  Created by Dave on 19/02/2023.
//

import Foundation

struct Sound: Hashable {
    let filename: String
    let name: String
}

let sound1 = Sound(filename: "flyby_notification_no_bell.aiff", name: "Fly-by")
let sound2 = Sound(filename: "flyby_notification_bell.aiff", name: "Fly-by with bell")
let sound3 = Sound(filename: "notification_1.aiff", name: "Pops")
let sound4 = Sound(filename: "notification_2.aiff", name: "Bong")
let sound5 = Sound(filename: "notification_3.aiff", name: "Dings")

let soundFiles = [sound1, sound2, sound3, sound4, sound5]

//
//  EventView.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct EventView: View {
    
    let raceEvent: RaceEvent
    
    var body: some View {
        Text(raceEvent.eventName)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(raceEvent: exampleEvent)
    }
}

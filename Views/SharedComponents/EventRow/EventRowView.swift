//
//  EventRowView.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct EventRowView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    @State private var liveColour: Color = Color(red: 0, green: 0.5, blue: 0)
    @State private var flashColour: Color = Color(red: 0, green: 1, blue: 0)

    let raceEvent: RaceEvent
    
    var body: some View {
        
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(raceEvent.eventName)
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        if raceEvent.sessionInProgress() != nil {
                            if raceEvent.sessionInProgress()! && (sm.monthlySub || sm.annualSub) {
                                LiveCircleView()
                            } // if true
                        } // if not nil
                        
                        if raceEvent.eventComplete() {
                            Image(systemName: "checkmark.circle.fill")
                        }
                    } // hstack
                    .padding(.bottom, -2)
                    EventRowSeriesList(dc: dc, raceEvent: raceEvent)
                    HStack {
                        EventRowSessionDates(dc: dc, sm: sm, raceEvent: raceEvent)
                    } // hstack
                } // vstack
            } // hstack
        } // vstack
    }
}

struct EventRowView_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(dc: DataController(), sm: StoreManager(), raceEvent: exampleEvent)
    }
}

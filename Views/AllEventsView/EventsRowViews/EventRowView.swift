//
//  EventRowView.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct EventRowView: View {
    
    @ObservedObject var dc: DataController
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
                        if raceEvent.sessionInProgress != nil {
                            if raceEvent.sessionInProgress! {
                                Circle()
                                    .frame(width: 10)
                                    .foregroundColor(.white)
                                    .colorMultiply(liveColour)
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                            self.liveColour = flashColour
                                        }
                                    }
                            } // if true
                        } // if not nil
                    } // hstack
                    .padding(.bottom, -2)
                    EventRowSeriesRow(dc: dc, raceEvent: raceEvent)
                    HStack {
                        EventRowSessionDates(raceEvent: raceEvent)
                    }
                } // vstack
            } // hstack
        } // vstack
    }
}

struct EventRowView_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(dc: DataController(), raceEvent: exampleEvent)
    }
}

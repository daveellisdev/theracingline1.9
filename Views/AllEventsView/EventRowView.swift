//
//  EventRowView.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct EventRowView: View {
    
    @ObservedObject var dc: DataController
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
                    } // hstack
                    .padding(.bottom, -2)
                    HStack {
                        ForEach(raceEvent.seriesIds, id: \.self) { seriesId in
                            // get the series for the id
                            let series = dc.getSeriesById(seriesId: seriesId)
                            if series != nil {
                                EventRowSeriesName(series: series!)

                            } // if not nil
                        } // foreach
                        Spacer()
                    } // hstack
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

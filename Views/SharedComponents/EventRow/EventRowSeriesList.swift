//
//  EventRowSeriesRow.swift
//  theracingline
//
//  Created by Dave on 06/11/2022.
//

import SwiftUI

struct EventRowSeriesList: View {
    
    let dc: DataController
    let raceEvent: RaceEvent

    var body: some View {
                
        HStack {
            ForEach(raceEvent.seriesIds, id: \.self) { seriesId in
                
                // get the series for the id
                let series = dc.getSeriesById(seriesId: seriesId)
                if series != nil {
                    EventRowSeriesName(series: series!, shortName: true)
                } // if not nil
            } // foreach
            Spacer()
        } // hstack
    }
}

struct EventRowSeriesRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRowSeriesList(dc: DataController(), raceEvent: exampleEvent)
    }
}

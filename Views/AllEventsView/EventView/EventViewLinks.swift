//
//  EventViewLinks.swift
//  theracingline
//
//  Created by Dave on 07/11/2022.
//

import SwiftUI

struct EventViewLinks: View {
    
    var dc: DataController
    var raceEvent: RaceEvent
    
    var body: some View {
        
        ForEach(raceEvent.seriesIds, id: \.self) { seriesId in
            if let series = getSeriesById(id: seriesId) {
                GroupBox {
                    VStack {
                        HStack {
                            EventRowSeriesName(series: series, shortName: false)
                            Spacer()
                        } // hstack
                        
                        ForEach(series.streaming) { stream in
                            VStack {
                                ZStack {
//                                    RoundedRectangle(cornerRadius: 5)
//                                        .frame(height: 20)
//                                        .foregroundColor(.gray)
                                        
                                    GroupBox {
                                        HStack {
                                            Text(stream.country)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                            Text(stream.name)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                            Spacer()
                                        }.padding(-5)
                                    }
                                    
                                }
                            }
                                        
 
                        } //foreach
                    } // vstack
                } // groupbox
            } // iflet
        } // foreach
    } // body
    
    func getSeriesById(id: String) -> Series? {
        if let series = dc.series.first(where: { $0.seriesInfo.id == id }) {
            return series
        } else {
            return nil
        }
    }
}

struct EventViewLinks_Previews: PreviewProvider {
    static var previews: some View {
        EventViewLinks(dc: DataController(), raceEvent: exampleEvent)
    }
}

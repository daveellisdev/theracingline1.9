//
//  EventViewStreamingLinks.swift
//  theracingline
//
//  Created by Dave on 07/11/2022.
//

import SwiftUI

struct EventViewLinks: View {
    
    var dc: DataController
    var raceEvent: RaceEvent
    
    var body: some View {
        
        GroupBox {
            HStack {
                Text("Official Links")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                
            } // hstack
            
            ForEach(raceEvent.seriesIds, id: \.self) { seriesId in
                if let series = getSeriesById(id: seriesId) {
                    GroupBox {
                        VStack {
                            HStack {
                                EventRowSeriesName(series: series, shortName: false)
                                Spacer()
                            } // hstack
                            VStack {
                                Link(destination: URL(string: series.links.official)!) {
                                    GroupBox {
                                        HStack {
                                            Text("Official Site")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                            Spacer()
                                            Image(systemName: "arrow.up.right.square")
                                                .font(.caption)
                                        }.padding(-5)
                                    } // groupbox
                                } // link
                                
                            
                                Link(destination: URL(string: series.links.timing)!) {
                                    GroupBox {
                                        HStack {
                                            Text("Live Timing")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                            Spacer()
                                            Image(systemName: "arrow.up.right.square")
                                                .font(.caption)
                                        }.padding(-5)
                                    } // groupbox
                                } // link
                            } // vstack
                        } // vstack
                    } // groupbox
                } // iflet
            } // foreach
        } // groupbox
        
        GroupBox {
            HStack {
                Text("Streaming Links")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                
            } // hstack
            
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
                                        Link(destination: URL(string: stream.url)!) {
                                            GroupBox {
                                                HStack {
                                                    Text(stream.country)
                                                        .font(.caption)
                                                        .fontWeight(.bold)
                                                    Text(stream.name)
                                                        .font(.caption)
                                                        .fontWeight(.bold)
                                                    Spacer()
                                                    Image(systemName: "arrow.up.right.square")
                                                        .font(.caption)
                                                }.padding(-5)
                                            } // groupbox
                                        } // link
                                    } // zstack
                                } // vstack
                            } //foreach
                        } // vstack
                    } // groupbox
                } // iflet
            } // foreach
        } // groupbox
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
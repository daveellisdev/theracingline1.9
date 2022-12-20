//
//  SessionView.swift
//  theracingline
//
//  Created by Dave on 15/11/2022.
//

import SwiftUI

struct SessionView: View {
    
    @ObservedObject var dc: DataController
    let session: Session
    
    var body: some View {
        
        let series = dc.getSeriesById(seriesId: session.seriesId)
        let circuitName: String = session.circuit.circuit
        let circuitLayout: String? = session.circuit.circuitLayout
        let circuitInfo = dc.getCircuitByName(circuit: circuitName)
        
        if series != nil {
            ScrollView {
                VStack {
                    if session.sessionInProgress() != nil && session.sessionInProgress()! {
                        SessionViewSessionLive(dc: dc, session: session)
                    } else {
                        SessionViewSessionUpcoiming(dc: dc, session: session, series: series!)
                    }
                    GroupBox {
                        HStack {
                            Text("Official Links")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        
                        Link(destination: URL(string: series!.links.official)!) {
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
                        
                        Link(destination: URL(string: series!.links.timing)!) {
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
                    }
                    GroupBox {
                        HStack {
                            Text("Streaming Links")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        
                        ForEach(series!.streaming) { stream in
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
                        } // foreach
                    }
                    if circuitInfo != nil {
                        EventViewCircuitMap(circuit: circuitInfo!, circuitLayout: circuitLayout)
                    }
                } // vstack
            } // scrollview
            .navigationTitle(series!.seriesInfo.name)
            .padding(.horizontal)
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(dc: DataController(), session: exampleSession)
    }
}

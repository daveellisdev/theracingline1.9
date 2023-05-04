//
//  SeriesViewEventView.swift
//  theracingline
//
//  Created by Dave on 29/12/2022.
//

import SwiftUI
import MapKit

struct EventView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State private var showingFilterSheet = false

    let event: RaceEvent
    
    var body: some View {
        
        let circuitName: String = event.sessions[0].circuit.circuit
        let circuitLayout: String? = event.sessions[0].circuit.circuitLayout
        let circuitInfo = dc.getCircuitByName(circuit: circuitName)
        
        ScrollView {
            VStack {
                if !sm.subscribed {
                    Button {
                        showingFilterSheet = true
                    } label: {
                        PremiumBarSlim()
                    }.sheet(isPresented: $showingFilterSheet){
                        SubscriptionView(dc: dc, sm: sm)
                    }
                }
                GroupBox {
                    VStack(alignment: .leading) {
                        EventRowSeriesList(dc: dc, raceEvent: event)

                        HStack {
                            VStack {
                                HStack {
                                    Text("Circuit: \(circuitName)")
                                        .font(.caption)
                                    Spacer()
                                }
                                
                                if(circuitLayout != nil) {
                                    HStack {
                                        Text("Layout: \(circuitLayout!)")
                                            .font(.caption)
                                        Spacer()
                                    }
                                } // if circuitlayout
                            } // vstack
                        } // hstack
                    } // vstack
                } // Event and Circuit Group Box
                
                Group {
                    LinkButtons(dc: dc, seriesIds: event.seriesIds)
                }
                
                ForEach(event.sessionsSortedByDate()) { session in
                    let series = dc.getSeriesById(seriesId: session.seriesId)
                    
                    if series != nil {
                        GroupBox {
                            SessionView(dc: dc, sm: sm, series: series!, session: session)
                        }
                    } // if series is not nil
                } // for each
                
                if circuitInfo != nil && circuitLayout != nil {
                    let circuit = dc.getCircuitByName(circuit: circuitName)
                    if circuit != nil {
                        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(circuit!.location.lat), longitude: CLLocationDegrees(circuit!.location.long)), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                        
                        CircuitMapView(region: region)
                    }
                }
            }.padding(.horizontal)
            
                        
        }.navigationTitle(event.eventName)
    }
}

struct SeriesViewEventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(dc: DataController(), sm: StoreManager(), event: exampleEvent)
    }
}

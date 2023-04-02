//
//  SessionDetailsView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI
import MapKit

struct SessionDetailsView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    let session: Session
    
    var body: some View {
        let circuitName: String = session.circuit.circuit
        let circuitLayout: String? = session.circuit.circuitLayout
        let circuitInfo = dc.getCircuitByName(circuit: circuitName)
        let series = dc.getSeriesById(seriesId: session.seriesId)
        
        ScrollView {
            VStack {
                if series != nil {
                    GroupBox {
                        HStack {
                            EventRowSeriesName(series: series!, shortName: true)
                            Spacer()
                            if session.isInProgress() && (sm.monthlySub || sm.annualSub) {
                                LiveCircleView()
                            }
                        }
                        
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
                    } // groupbox
                    
                    Group {
                        LinkButtons(dc: dc, seriesIds: [session.seriesId])
                    } // groupbox
                    
                    GroupBox {
                        SessionView(dc: dc, sm: sm, series: series!, session: session)
                    }
                            
                } // if series is not nil
                
                if circuitInfo != nil && circuitLayout != nil {
                    let circuit = dc.getCircuitByName(circuit: circuitName)
                    if circuit != nil {
                        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(circuit!.location.lat), longitude: CLLocationDegrees(circuit!.location.long)), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                        
                        CircuitMapView(region: region)
                    }
                } // if circuit not nil
            } // vstack
        }.padding(.horizontal)
        .navigationTitle(session.session.sessionName) // scrollview
    }
}

struct SessionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailsView(dc: DataController(), sm: StoreManager(), session: exampleSession)
    }
}

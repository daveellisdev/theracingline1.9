//
//  EventViewCircuitMap.swift
//  theracingline
//
//  Created by Dave on 09/11/2022.
//

import SwiftUI
import MapKit

struct EventViewCircuitMap: View {
    
    var circuit: Circuit
    var circuitLayout: String?

    var body: some View {
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(circuit.location.lat), longitude: CLLocationDegrees(circuit.location.long)), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        
        GroupBox {
            HStack {
                Text("Circuit Information")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                
            } // hstack
            GroupBox {
                VStack {
                    HStack {
                        Text(circuit.circuit)
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    } // hstack
                    if(circuitLayout != nil) {
                        HStack {
                            Text("Layout: \(circuitLayout!)")
                            Spacer()
                        }
                    }
                    HStack {
                        Text(circuit.emoji)
                        Text(circuit.country)
                        Spacer()
                    }
                } // vstack
            } //groupbox
            
            GroupBox {
                EventViewMapView(region: region)
                
            }
        } // groupbox
    }
}

struct EventViewCircuitMap_Previews: PreviewProvider {
    static var previews: some View {
        EventViewCircuitMap(circuit: exampleCircle)
    }
}

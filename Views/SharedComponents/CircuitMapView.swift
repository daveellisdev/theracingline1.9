//
//  EventViewMapView.swift
//  theracingline
//
//  Created by Dave on 10/11/2022.
//

import SwiftUI
import MapKit

struct CircuitMapView: View {
    
    @State var region: MKCoordinateRegion

//    @State var regionTest = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(25.049136), longitude: CLLocationDegrees(55.236425)), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
//
    var body: some View {
        
        Map(coordinateRegion: $region)
            .frame(height: 256)
            .cornerRadius(12)
            
    }
}

struct EventViewMapView_Previews: PreviewProvider {
    static var previews: some View {
      CircuitMapView(region: MKCoordinateRegion())
    }
}

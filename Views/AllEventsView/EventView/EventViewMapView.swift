//
//  EventViewMapView.swift
//  theracingline
//
//  Created by Dave on 10/11/2022.
//

import SwiftUI
import MapKit

struct EventViewMapView: View {
    
    @State var region: MKCoordinateRegion
//    @State private var mapType: MKMapType = .satellite
    
    var body: some View {
        
        Map(coordinateRegion: $region)
            .frame(height: 256)
            .cornerRadius(12)
            
    }
}

struct EventViewMapView_Previews: PreviewProvider {
    static var previews: some View {
      EventViewMapView(region: MKCoordinateRegion())
    }
}

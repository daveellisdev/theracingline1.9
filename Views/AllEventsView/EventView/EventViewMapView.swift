//
//  EventViewMapView.swift
//  theracingline
//
//  Created by Dave on 10/11/2022.
//

import SwiftUI
import MapKit
import Foundation


struct EventViewMapView: View {
    
    @State var region: MKCoordinateRegion
    @State private var mapType: MKMapType = .satellite
    
    var body: some View {
//        MapViewUIKit()
        Map(coordinateRegion: $region)
            .overlay(
//                NavigationLink() {
                    HStack {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(Color.white)
                            .imageScale(.large)
                        Text("Muh Tyres")
                            .foregroundColor(.accentColor)
                            .fontWeight(.bold)
                    } // HSTACK
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(
                        Color.black
                            .opacity(0.4)
                            .cornerRadius(8)
                    )
//                } // NAV
                    .padding(12), alignment: .topTrailing
            )
            .frame(height: 256)
            .cornerRadius(12)
    }
}

struct EventViewMapView_Previews: PreviewProvider {
    static var previews: some View {
      EventViewMapView(region: MKCoordinateRegion())
    }
}

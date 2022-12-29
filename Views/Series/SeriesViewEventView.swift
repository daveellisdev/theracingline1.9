//
//  SeriesViewEventView.swift
//  theracingline
//
//  Created by Dave on 29/12/2022.
//

import SwiftUI

struct SeriesViewEventView: View {
    var body: some View {
        VStack{
            Text("Circuit Info")
            Text("Session Info")
            Text("Other Series in this event")
            Text("Official Links")
            Text("Streaming Links")
            Text("Circuit Map")
            Text("Previous and next race buttons")
        }
        
    }
}

struct SeriesViewEventView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesViewEventView()
    }
}

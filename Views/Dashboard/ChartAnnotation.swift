//
//  ChartBar.swift
//  theracingline
//
//  Created by Dave on 22/11/2022.
//

import SwiftUI
import Charts

struct ChartAnnotation: View {
    
    let seriesName: String
    let raceTime: String

    var body: some View {
        
        VStack(alignment: .leading) {
            Text(seriesName)
                .font(.caption)
                .fontWeight(.bold)
                .colorInvert()
            Text(raceTime)
                .font(.caption2)
                .colorInvert()
        } // vstack
    }
}

struct ChartBar_Previews: PreviewProvider {
    static var previews: some View {
        ChartAnnotation(seriesName: "F1", raceTime: "18:00")
    }
}

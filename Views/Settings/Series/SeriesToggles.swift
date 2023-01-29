//
//  SeriesToggle.swift
//  theracingline
//
//  Created by Dave on 29/01/2023.
//

import SwiftUI

struct SeriesToggle: View {
    
    @ObservedObject var dc: DataController
    @State private var isOn = false
    var type: toggleType
    var series: Series
    
    var body: some View {
        HStack {
            Toggle(series.seriesInfo.name, isOn: $isOn)
        }.padding(.horizontal)
    }
}

struct SeriesToggle_Previews: PreviewProvider {
    static var previews: some View {
        SeriesToggle(dc: DataController(), type: .visible, series: exampleSeries)
    }
}

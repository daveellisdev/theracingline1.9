//
//  SeriesToggle.swift
//  theracingline
//
//  Created by Dave on 29/01/2023.
//

import SwiftUI

struct SeriesToggle: View {
    
    @ObservedObject var dc: DataController
    @State var isOn: Bool
    var type: toggleType
    var series: Series
    
    var body: some View {
        HStack {
            Toggle(series.seriesInfo.name, isOn: $isOn)
                .onChange(of: isOn) { value in
                    // update value in the dc file
                    
                    // save the settings
                }
        }.padding(.horizontal)
    }
    
    
}

struct SeriesToggle_Previews: PreviewProvider {
    static var previews: some View {
        SeriesToggle(dc: DataController(), isOn: true, type: .visible, series: exampleSeries)
    }
}

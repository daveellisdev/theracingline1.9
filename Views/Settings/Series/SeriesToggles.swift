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
    var type: ToggleType
    var series: Series
    
    var body: some View {
        HStack {
            Toggle(series.seriesInfo.name, isOn: $isOn)
                .onChange(of: isOn) { value in
                    updateSavedSettings(type: type, series: series, newValue: isOn)
                }
        }.padding(.horizontal)
    }
    
    func updateSavedSettings(type: ToggleType, series: Series, newValue: Bool) {
        
        // update previously saved setting
        dc.updatedSeriesSavedSettings(type: type, series: series, newValue: newValue)
        
        // save settings
        dc.saveSavedSettings()
    }
}

struct SeriesToggle_Previews: PreviewProvider {
    static var previews: some View {
        SeriesToggle(dc: DataController(), isOn: true, type: .visible, series: exampleSeries)
    }
}

//
//  SeriesToggle.swift
//  theracingline
//
//  Created by Dave on 29/01/2023.
//

import SwiftUI

struct SeriesToggle: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    @State private var isOn = false
    var type: ToggleType
    var series: Series
    
    var body: some View {
        
        
        
        HStack {
            Toggle(series.seriesInfo.name, isOn: $isOn)
                .onChange(of: dc.visibleSeries, perform: { value in
                    checkIfSeriesVisible()
                })
                .onChange(of: isOn) { value in
                    updateSavedSettings(type: type, series: series, newValue: isOn)
                }
        }.padding(.horizontal)
            .onAppear {
                checkIfSeriesVisible()
            }
    }
    
    func updateSavedSettings(type: ToggleType, series: Series, newValue: Bool) {
        // update previously saved setting
        dc.updatedSeriesSavedSettings(type: type, series: series, newValue: newValue)
        
        // save settings
        dc.saveSavedSettings()
    }
    
    func checkIfSeriesVisible(){
        switch type {
        case .visible:
            isOn = dc.visibleSeries[series.seriesInfo.id]!
        case .favourite:
            isOn = dc.favouriteSeries[series.seriesInfo.id]!
        case .notification:
            isOn = dc.notificationSeries[series.seriesInfo.id]!
        }
    }
}

struct SeriesToggle_Previews: PreviewProvider {
    static var previews: some View {
        SeriesToggle(dc: DataController(), sm: StoreManager(), type: .visible, series: exampleSeries)
    }
}

//
//  SeriesListView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct SeriesListView: View {
    
    @ObservedObject var dc: DataController
    @State var navStack = NavigationPath()
    
    var body: some View {
        let series = dc.series
        NavigationStack(path: $navStack) {
            List(series) { series in
                NavigationLink(value: series) {
                    SeriesListViewSeriesName(series: series)
                }
            }.navigationDestination(for: Series.self) { series in
                SeriesListViewEventList(dc: dc, navStack: $navStack, series: series)
            }.navigationTitle("Series")
        }
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListView(dc: DataController())
    }
}

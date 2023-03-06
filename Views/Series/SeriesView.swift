//
//  SeriesView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI

struct SeriesView: View {
    
    @ObservedObject var dc: DataController
    @State var navStack = NavigationPath()
    @State private var showingFilterSheet = false
    
    var body: some View {
        
        
        
        let series = dc.series
        NavigationStack(path: $navStack) {
            if !dc.storeManager.subscribed {
                Button {
                    showingFilterSheet = true
                } label: {
                    GroupBox {
                        PremiumBarSlim().padding(.horizontal)
                    }
                }.sheet(isPresented: $showingFilterSheet){
                    SubscriptionView(dc: dc)
                }
            }
            List(series) { series in
                NavigationLink(value: series) {
                    SeriesViewSeriesName(series: series)
                }
            }.navigationDestination(for: Series.self) { series in
                SeriesViewEventList(dc: dc, navStack: $navStack, series: series)
            }.navigationTitle("Series")
        }
    }
}

struct SeriesView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesView(dc: DataController())
    }
}

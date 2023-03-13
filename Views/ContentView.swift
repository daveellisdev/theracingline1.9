//
//  ContentView.swift
//  theracingline
//
//  Created by Dave on 15/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dc: DataController
    
    var body: some View {
        
        TabView {
            DashboardView(dc: dc)
                .tabItem {
                    Label("Dash", systemImage: "house.fill")
                }
            DayListView(dc: dc)
                .tabItem {
                    Label("Day", systemImage: "30.square.fill")
                }
            EventListView(dc: dc)
                .tabItem {
                    Label("Events", systemImage: "flag.fill")
                }
            SeriesListView(dc: dc)
                .tabItem {
                    Label("Series", systemImage: "list.number")
                }
            SettingsView(dc: dc)
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }.onAppear() {
            dc.storeManager.restoreSubscriptionStatus()
            dc.downloadData()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dc: DataController())
    }
}

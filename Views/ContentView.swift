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
            DashboardView()
                .tabItem {
                    Label("Dash", systemImage: "house.fill")
                }
            DayView()
                .tabItem {
                    Label("Day", systemImage: "30.square.fill")
                }
            AllEventsView(dc: dc)
                .tabItem {
                    Label("Events", systemImage: "flag.fill")
                }
            SeriesView()
                .tabItem {
                    Label("Series", systemImage: "list.number")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dc: DataController())
    }
}

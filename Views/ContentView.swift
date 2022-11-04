//
//  ContentView.swift
//  theracingline
//
//  Created by Dave on 15/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dataController: DataController
    
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
            DayView()
                .tabItem {
                    Label("All Races", systemImage: "flag.fill")
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
        ContentView(dataController: DataController())
    }
}

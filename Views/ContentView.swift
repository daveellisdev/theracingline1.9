//
//  ContentView.swift
//  theracingline
//
//  Created by Dave on 15/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    var body: some View {
        
        TabView {
//            DashboardView(dc: dc, sm: sm)
//                .tabItem {
//                    Label("Dash", systemImage: "house.fill")
//                }
            DayListView(dc: dc, sm: sm)
                .tabItem {
                    Label("Sessions", systemImage: "30.square.fill")
                }
            EventListView(dc: dc, sm: sm)
                .tabItem {
                    Label("Events", systemImage: "flag.fill")
                }
            SeriesListView(dc: dc, sm: sm)
                .tabItem {
                    Label("Series", systemImage: "list.number")
                }
            SettingsView(dc: dc, sm: sm)
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dc: DataController(), sm: StoreManager())
    }
}

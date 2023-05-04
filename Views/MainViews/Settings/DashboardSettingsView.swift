//
//  DashboardSettingsView.swift
//  theracingline
//
//  Created by Dave on 04/05/2023.
//

import SwiftUI

struct DashboardSettingsView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    @State private var showRace = true
    @State private var showQualifying = true
    @State private var showPractice = true
    @State private var showTesting = true
    @State private var showCompletedEvents = true

    
    @State var navStack: NavigationPath
    
    var body: some View {
        ScrollView {
            VStack {
                Text("These are not hooked to anything yet")
                GroupBox(label: SettingsLabelView(labelText: "Sessions", labelImage: "list.bullet")) {
                    Divider().padding(.vertical, 4)
                    Toggle("Race", isOn: $showRace)
                    Toggle("Qualifying", isOn: $showQualifying)
                    Toggle("Practice", isOn: $showPractice)
                    Toggle("Testing", isOn: $showTesting)
                }
                GroupBox(label: SettingsLabelView(labelText: "Completed Events", labelImage: "clock.arrow.circlepath")) {
                    Divider().padding(.vertical, 4)
                    Toggle("Show completed events", isOn: $showCompletedEvents)
                }
            } // vstack
        } // scrollview
        .padding(.horizontal, 20)
        .navigationBarTitle("Dashboard")
    } // body
}

struct DashboardSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardSettingsView(dc: DataController(), sm: StoreManager(), navStack: NavigationPath())
    }
}

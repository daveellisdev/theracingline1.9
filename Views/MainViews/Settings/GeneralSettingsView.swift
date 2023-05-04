//
//  GeneralSettings.swift
//  theracingline
//
//  Created by Dave on 04/05/2023.
//

import SwiftUI

struct GeneralSettingsView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    @State private var showCompletedEvents = true
    
    @State var navStack: NavigationPath

    var body: some View {
        ScrollView {
            VStack {
                Text("These are not hooked to anything yet")
                GroupBox(label: SettingsLabelView(labelText: "Completed Events", labelImage: "clock.arrow.circlepath")) {
                    Divider().padding(.vertical, 4)
                    Toggle("Show completed events", isOn: $showCompletedEvents)
                }
            } // vstack
        } // scrollview
        .padding(.horizontal, 20)
        .navigationBarTitle("General")
    } // body
}

struct GeneralSettings_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView(dc: DataController(), sm: StoreManager(), navStack: NavigationPath())
    }
}

//
//  SeriesSettings.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct SeriesSettings: View {
    
    @ObservedObject var dc: DataController
    @State var navStack: NavigationPath

    var body: some View {
        GroupBox(label: SettingsLabelView(labelText: "Series", labelImage: "list.number")){
            Divider().padding(.vertical, 4)
            NavigationLink {
                SeriesSettingsView(dc: dc, navStack: navStack)
            } label: {
                HStack {
                    Image(systemName: "list.bullet")
                    Text("Series Selection")
                    Spacer()
                    Image(systemName: "chevron.right")

                }
            } // navlink
            
            Divider().padding(.vertical, 4)
            
            NavigationLink {
                Text("Notifications")
            } label: {
                HStack {
                    Image(systemName: "app.badge")
                    Text("Notifications")
                    Spacer()
                    Image(systemName: "chevron.right")

                }
            } // navlink
        } // groupbox
        .foregroundColor(.primary)

    } // bodu
}

struct SeriesSettings_Previews: PreviewProvider {
    static var previews: some View {
        SeriesSettings(dc: DataController(), navStack: NavigationPath())
    }
}

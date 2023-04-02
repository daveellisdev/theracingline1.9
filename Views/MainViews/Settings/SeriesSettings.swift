//
//  SeriesSettings.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct SeriesSettings: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State var navStack: NavigationPath

    var body: some View {
        GroupBox(label: SettingsLabelView(labelText: "Series", labelImage: "list.number")){
            Divider().padding(.vertical, 4)
            NavigationLink {
                SeriesSettingsView(dc: dc, sm: sm, navStack: navStack)
            } label: {
                HStack {
                    Image(systemName: "list.bullet")
                    Text("Series Selection")
                    Spacer()
                    Image(systemName: "chevron.right")

                }
            } // navlink
            
            
            if sm.monthlySub || sm.annualSub {
                
                Divider().padding(.vertical, 4)
                
                NavigationLink {
                    NotificationsSettingsView(dc: dc, sm: sm, navStack: navStack)
                } label: {
                    HStack {
                        Image(systemName: "app.badge")
                        Text("Notifications")
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }
                } // navlink
                
                Divider().padding(.vertical, 4)
            
                NavigationLink {
                    SoundSettingsView(dc: dc, navStack: navStack)
                } label: {
                    HStack {
                        Image(systemName: "waveform")
                        Text("Notification Sound")
                        Spacer()
                        Image(systemName: "chevron.right")

                    }
                } // navlink
            }

        } // groupbox
        .foregroundColor(.primary)

    } // bodu
}

struct SeriesSettings_Previews: PreviewProvider {
    static var previews: some View {
        SeriesSettings(dc: DataController(), sm: StoreManager(), navStack: NavigationPath())
    }
}

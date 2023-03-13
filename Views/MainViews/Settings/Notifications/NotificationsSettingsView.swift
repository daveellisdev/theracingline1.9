//
//  NotificationsSettingsView.swift
//  theracingline
//
//  Created by Dave on 18/02/2023.
//

import SwiftUI

struct NotificationsSettingsView: View {
    
    @ObservedObject var dc: DataController
    @State var navStack: NavigationPath
    @State var selected = 0
    
    var body: some View {
        
        let notficationOffset = dc.loadNotificationOffset()
        
        NavigationStack(path: $navStack) {
            VStack {
                Picker(selection: $selected, label: Text("Picker"), content: {
                    Text("Series").tag(0)
                    Text("Sessions").tag(1)
                    Text("Offset").tag(2)
                }).pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selected, perform: { value in
    //                data.simpleMenuHaptics()
                })
                
                if selected == 0 {
                    SeriesNotificationSettings(dc: dc)
                } else if selected == 1 {
                    NotificationSessionsSettings(dc: dc)
                } else if selected == 2 {
                    NotificationOffsetPicker(dc: dc, selectedDays: notficationOffset.days, selectedHours: notficationOffset.hours, selectedMinutes: notficationOffset.minutes)
                }
            } // vstack
            .navigationTitle("Notifications")
        } // navstack
    }
}

struct NotificationsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsSettingsView(dc: DataController(), navStack: NavigationPath())
    }
}

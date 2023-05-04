//
//  NotificationSessionsSettings.swift
//  theracingline
//
//  Created by Dave on 19/02/2023.
//

import SwiftUI

struct NotificationSessionsSettings: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager

    var body: some View {
        VStack {
            GroupBox {
                Text("Defines which sessions you receive notifications for")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            Group {
                SessionToggles(dc: dc, sm: sm, isOn: dc.applicationSavedSettings.raceNotifications, sessionTypeEnum: .race, sessionType: "Race")
                SessionToggles(dc: dc, sm: sm, isOn: dc.applicationSavedSettings.qualifyingNotifications, sessionTypeEnum: .qualifying, sessionType: "Qualifying")
                SessionToggles(dc: dc, sm: sm, isOn: dc.applicationSavedSettings.practiceNotifications, sessionTypeEnum: .practice, sessionType: "Practice")
                SessionToggles(dc: dc, sm: sm, isOn: dc.applicationSavedSettings.testingNotifications, sessionTypeEnum: .testing, sessionType: "Testing")
            }
            Spacer()
        }
    }
    
    
}

struct NotificationSessionsSettings_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSessionsSettings(dc: DataController(), sm: StoreManager())
    }
}

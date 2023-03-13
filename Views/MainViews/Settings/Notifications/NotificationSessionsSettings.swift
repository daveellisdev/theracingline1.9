//
//  NotificationSessionsSettings.swift
//  theracingline
//
//  Created by Dave on 19/02/2023.
//

import SwiftUI

struct NotificationSessionsSettings: View {
    
    @ObservedObject var dc: DataController

    var body: some View {
        VStack {
            GroupBox {
                Text("This defines which sessions you receive notificationsd for.")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
            Group {
                SessionToggles(dc: dc, isOn: dc.applicationSavedSettings.raceNotifications, sessionTypeEnum: .race, sessionType: "Race")
                SessionToggles(dc: dc, isOn: dc.applicationSavedSettings.qualifyingNotifications, sessionTypeEnum: .qualifying, sessionType: "Qualifying")
                SessionToggles(dc: dc, isOn: dc.applicationSavedSettings.practiceNotifications, sessionTypeEnum: .practice, sessionType: "Practice")
                SessionToggles(dc: dc, isOn: dc.applicationSavedSettings.testingNotifications, sessionTypeEnum: .testing, sessionType: "Testing")
            }
            Spacer()
        }
    }
    
    
}

struct NotificationSessionsSettings_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSessionsSettings(dc: DataController())
    }
}

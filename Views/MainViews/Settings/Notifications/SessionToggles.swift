//
//  SessionToggles.swift
//  theracingline
//
//  Created by Dave on 19/02/2023.
//

import SwiftUI

struct SessionToggles: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    @State var isOn: Bool
    var sessionTypeEnum: SessionType
    var sessionType: String
    
    var body: some View {
        HStack {
            Toggle(sessionType, isOn: $isOn)
                .onChange(of: isOn) { value in
                    // update notification settings
                    updateSavedNotificationSettings(sessionTypeEnum: sessionTypeEnum, newValue: isOn)
                }
        }.padding(.horizontal)
    }
    
    func updateSavedNotificationSettings(sessionTypeEnum: SessionType, newValue: Bool) {
        
        // update previouslt saved setting
        dc.updateNotificationSavedSettings(sessionTypeEnum: sessionTypeEnum, newValue: newValue)
        
        // save settings
        dc.saveSavedSettings()
    }
}

//struct SessionToggles_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionToggles()
//    }
//}

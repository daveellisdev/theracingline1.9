//
//  PremiumBoxView.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct PremiumBoxView: View {
    var body: some View {
        
        GroupBox(label: SettingsLabelView(labelText: "TRL Premium", labelImage: "flag.checkered")) {
            Divider().padding(.vertical, 4)
            Text("Subscribe for race start times and session notifications in your time zone.")
                .font(.caption)
            Divider().padding(.vertical, 4)
            Text("BUTTONS")
            Divider().padding(.vertical, 4)
            Text("MORE INFORMATION")
        
        } //GROUPBOX
    }
}

struct PremiumBoxView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumBoxView()
    }
}

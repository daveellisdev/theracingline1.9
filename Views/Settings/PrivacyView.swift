//
//  PrivacyView.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        GroupBox(label: SettingsLabelView(labelText: "Privacy", labelImage: "lock")) {
            Divider().padding(.vertical, 4)
            Text("PRIVACY")
            Text("T&CS")
        } //GROUPBOX
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}

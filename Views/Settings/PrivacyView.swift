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
            HStack {
                Image(systemName: "lock.shield.fill")
                Text("Privacy Policy")
                Spacer()
            }
            Divider().padding(.vertical, 4)
            HStack {
                Image(systemName: "newspaper")
                Text("T&Cs")
                Spacer()
            }
        } //GROUPBOX
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}

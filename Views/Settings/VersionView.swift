//
//  VersionView.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct VersionView: View {
    var body: some View {
        GroupBox(label: SettingsLabelView(labelText: "Version", labelImage: "info.circle")) {
            Divider().padding(.vertical, 4)
            HStack {
                Text("Version 2.0")
                Spacer()
            }
        } //GROUPBOX
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        VersionView()
    }
}

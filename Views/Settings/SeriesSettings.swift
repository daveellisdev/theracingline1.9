//
//  SeriesSettings.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct SeriesSettings: View {
    var body: some View {
        GroupBox(label: SettingsLabelView(labelText: "Series", labelImage: "list.number")){
            Divider().padding(.vertical, 4)
            HStack {
                Image(systemName: "list.star")
                Text("Favourite Series")
                Spacer()
            }
            Divider().padding(.vertical, 4)
            HStack {
                Image(systemName: "list.bullet")
                Text("Visible Series")
                Spacer()
            }
            Divider().padding(.vertical, 4)
            HStack {
                Image(systemName: "app.badge")
                Text("Notifications")
                Spacer()
            }
        }
    }
}

struct SeriesSettings_Previews: PreviewProvider {
    static var previews: some View {
        SeriesSettings()
    }
}

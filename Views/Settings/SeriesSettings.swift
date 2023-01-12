//
//  SeriesSettings.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct SeriesSettings: View {
    var body: some View {
        GroupBox(label: SettingsLabelView(labelText: "Series", labelImage: "app.badge")){
            Divider().padding(.vertical, 4)
            Text("FAV SERIES")
            Text("VISIBLE SERIES")
            Text("NOTIFICATIONS")
        }
    }
}

struct SeriesSettings_Previews: PreviewProvider {
    static var previews: some View {
        SeriesSettings()
    }
}

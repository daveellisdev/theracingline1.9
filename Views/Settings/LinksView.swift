//
//  LinksView.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct LinksView: View {
    var body: some View {
        
        GroupBox(label: SettingsLabelView(labelText: "Links", labelImage: "link")) {
            Divider().padding(.vertical, 4)
            Text("FAQS")
            Text("LINKS")
        } //GROUPBOX
    }
}

struct LinksView_Previews: PreviewProvider {
    static var previews: some View {
        LinksView()
    }
}

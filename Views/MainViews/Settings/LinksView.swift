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
            HStack {
                Image(systemName: "questionmark.bubble.fill")
                Text("FAQs")
                Spacer()
            }
            Divider().padding(.vertical, 4)

            HStack {
                Image(systemName: "link")
                Text("Links")
                Spacer()
            }
        } //GROUPBOX
    }
}

struct LinksView_Previews: PreviewProvider {
    static var previews: some View {
        LinksView()
    }
}

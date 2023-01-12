//
//  AboutView.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        GroupBox(label: SettingsLabelView(labelText: "About", labelImage: "info.circle")){
            Divider().padding(.vertical, 4)
            
            HStack(alignment: .center, spacing: 10) {
                Image("tRL-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(9)
                Text("TheRacingLine is your personalised motorsport calendar tool. Custom notification times for the series you care about. All in a lightweight, independently-developed app.")
                    .font(.footnote)
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

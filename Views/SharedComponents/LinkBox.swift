//
//  LinkBox.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct LinkBox: View {
    
    let linkType: LinkType
    let linkText: String
    let buttonText: String
    let linkUrl: String
    
    var body: some View {
        GroupBox {
            HStack {
                Text(linkText)
                    .font(.caption)
                Spacer()
                Button(linkType == .streaming ? buttonText : "🌍") {
                    
                }.buttonStyle(.bordered)
                    .padding(-10)
            }
        }
    }
}

struct LinkBox_Previews: PreviewProvider {
    static var previews: some View {
        LinkBox(linkType: .official, linkText: "Official Site", buttonText: "Official Site", linkUrl: "http://www.f1.com")
    }
}

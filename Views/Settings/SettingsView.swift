//
//  SettingsView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var dc: DataController
    @State var navStack = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navStack) {
            ScrollView {
                VStack {
                    AboutView()
                    PremiumBar()
//                    PremiumBoxView()
                    SeriesSettings()
                    LinksView()
                    PrivacyView(navStack: navStack)
                    VersionView()
                } // vstack
            }.navigationTitle("Dasboard")
                .padding(.horizontal)
        } // navstack
    } // body
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(dc: DataController())
    }
}

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
    @State private var showingFilterSheet = false

    var body: some View {
        NavigationStack(path: $navStack) {
            ScrollView {
                VStack {
                    AboutView()
                    Button {
                        showingFilterSheet = true
                    } label: {
                        PremiumBar()
                    }.sheet(isPresented: $showingFilterSheet){
                        SubscriptionView()
                    }
                    SeriesSettings(dc: dc, navStack: navStack)
//                    LinksView()
                    PrivacyView(navStack: navStack)
                    VersionView()
                } // vstack
            }.navigationTitle("Settings")
                .padding(.horizontal)
        } // navstack
    } // body
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(dc: DataController())
    }
}

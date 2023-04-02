//
//  SettingsView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State var navStack = NavigationPath()
    @State private var showingFilterSheet = false

    var body: some View {
        NavigationStack(path: $navStack) {
            ScrollView {
                VStack {
                    AboutView()
                    ConsoleLogView(sm: sm)
                    if !sm.monthlySub && !sm.annualSub {
                        Button {
                            showingFilterSheet = true
                        } label: {
                            PremiumBar()
                        }.sheet(isPresented: $showingFilterSheet){
                            SubscriptionView(dc: dc, sm: sm)
                        }
                    }
                    SeriesSettings(dc: dc, sm: sm, navStack: navStack)
//                    LinksView()
                    PrivacyView(navStack: navStack)
                    VersionView()
                } // vstack
                .padding(.horizontal)
            }.navigationTitle("Settings")
                
        } // navstack
    } // body
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(dc: DataController(), sm: StoreManager())
    }
}

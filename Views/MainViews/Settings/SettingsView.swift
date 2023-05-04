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
    @State private var showingPaymentSheet = false

    var body: some View {
        NavigationStack(path: $navStack) {
            ScrollView {
                VStack {
                    AboutView()
                    if !sm.subscribed {
                        Button {
                            showingPaymentSheet = true
                        } label: {
                            PremiumBar()
                        }.sheet(isPresented: $showingPaymentSheet){
                            SubscriptionView(dc: dc, sm: sm)
                        }
                    }
                    SeriesSettings(dc: dc, sm: sm, navStack: navStack)
//                    LinksView()
                    PrivacyView(navStack: navStack)
                    VersionView(dc: dc, sm: sm)
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

//
//  theracinglineApp.swift
//  theracingline
//
//  Created by Dave on 15/10/2022.
//

import SwiftUI
import StoreKit

@main
struct theracinglineApp: App {
    
    @StateObject var sm = StoreManager()
    @ObservedObject var dc = DataController.shared
    @ObservedObject var nc = NotificationController.shared
    
    let productIDs = ["dev.daveellis.theracingline.coffee",
                      "dev.daveellis.theracingline.bronze",
                      "dev.daveellis.theracingline.silver",
                      "dev.daveellis.theracingline.gold",
                      "dev.daveellis.theracingline.annual"]

    var body: some Scene {

        WindowGroup {
            ContentView(dc: dc, sm: sm)
                .onAppear() {
                    
                    // on app loading. This is not when the app comes to the foreground
                    
                    // restore payment status
                    sm.restoreSubscriptionStatus()
                    SKPaymentQueue.default().add(sm)
                    sm.getProducts(productIDs: productIDs)
                    
                    // load saved settings
                    dc.loadSavedSettings()
                    
                    // load race data
                    dc.loadSeriesAndSessionData()
                    
                    // download new races
                    dc.downloadData()
                    
                    // rebuild notifications
                    rebuildNotifications()
                }
                .onChange(of: dc.unfilteredSessions, perform: { value in
                    rebuildNotifications()
                })
                .onChange(of: dc.notificationSeries, perform: { value in
                    rebuildNotifications()
                })
                .onChange(of: dc.applicationSavedSettings, perform: { value in
                    rebuildNotifications()
                })
                .onChange(of: sm.subscribed, perform: { value in
                    rebuildNotifications()
                })
        }
    }
    
    func rebuildNotifications() {
        if sm.subscribed {
            nc.rebuildNotifications()
        }
    }
}

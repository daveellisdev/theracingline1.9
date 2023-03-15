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
                    
                    // on app loading
                    
                    // restore payment status
                    sm.restoreSubscriptionStatus()
                    SKPaymentQueue.default().add(sm)
                    sm.getProducts(productIDs: productIDs)
                    
                    // load saved settings
                    dc.loadSavedSettings()
                    
                    // load saved series
                    dc.loadSeriesAndSessionData()
                    
                    // download new races
                    dc.downloadData()
                }
//                .onChange(of: dc.seriesSavedSettings, perform: { value in
//                    rebuildNotifications()
//                })
//                .onChange(of: dc.applicationSavedSettings, perform: { value in
//                    rebuildNotifications()
//                })
                .onChange(of: sm.subscribed, perform: { value in
                    print("onChangeHit")
                    rebuildNotifications()
                    print("onChangeFinished")
                })
        }
    }
    
    func rebuildNotifications() {
        if sm.subscribed {
            nc.rebuildNotifications()
        }
    }
}

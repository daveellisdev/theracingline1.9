//
//  SubscriptionView.swift
//  theracingline
//
//  Created by Dave on 25/02/2023.
//

import SwiftUI

struct SubscriptionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dc: DataController
    @State private var annualSelected: Bool = true
    
    var body: some View {
        ScrollView {
            
            HStack { // cancel button
                Button {
                    dc.applicationSavedSettings.subscribed = dc.storeManager.restoreSubscriptionStatus()
                    dc.saveSavedSettings()
                } label: {
                    Text("Restore")
                        .foregroundColor(.blue)
                }
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
            }.padding(.horizontal, 20)
                .padding(.top, 20)
            TabView {
                SubscriptionTabView(imageName: "play.display", title: "Weekend Dashboard", description: "A comprehensive guide to the weekends action.")
                SubscriptionTabView(imageName: "app.badge", title: "Custom Notifications", description: "Notifications for the events and series you want, when you want.")
                SubscriptionTabView(imageName: "stopwatch", title: "Race Times", description: "Event and session green flag times converted to your local time zone.")
                SubscriptionTabView(imageName: "square.dashed.inset.filled", title: "Widgets", description: "Customisable widgets for your home screen.")
                SubscriptionTabView(imageName: "flag.checkered", title: "More coming soon...", description: "Weather, live events, WatchOS support")
            }.frame(height: 360)
            .tabViewStyle(.page(indexDisplayMode: .always))
            .padding(.bottom, 20)
            
            Group {
                Text("Choose your plan")
                    .font(.title)
                    .fontWeight(.bold)
                HStack {
                    Button {
                        annualSelected = false
                    } label: {
                        SubscriptionButtonMonthlyView(dc: dc, selected: !annualSelected).padding(.horizontal, 10)
                    }
                    
                    Button {
                        annualSelected = true
                    } label: {
                        SubscriptionButtonAnnualView(dc: dc, selected: annualSelected)
                    }
                }
                Text("Auto-renews")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Button {
                let sub = dc.storeManager.getProductByName(productName: annualSelected == true ? "annual" : "gold")
                dc.applicationSavedSettings.subscribed = dc.storeManager.purchaseProduct(product: sub)
                dc.saveSavedSettings()
            } label: {
                Text("Subscribe")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .background(.green)
                    .cornerRadius(20)
            }
        }
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView(dc: DataController())
    }
}

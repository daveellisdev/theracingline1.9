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
    @ObservedObject var sm: StoreManager
    
    @State private var annualSelected: Bool = true
    
    var body: some View {
        ScrollView {
            
            HStack { // cancel button
                Button {
                    sm.restoreSubscriptionStatus()
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
                        SubscriptionButtonMonthlyView(dc: dc, sm: sm, selected: !annualSelected).padding(.horizontal, 10)
                    }
                    
                    Button {
                        annualSelected = true
                    } label: {
                        SubscriptionButtonAnnualView(dc: dc, sm: sm, selected: annualSelected)
                    }
                }
                Text("Auto-renews")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Button {
                let sub = sm.getProductByName(productName: annualSelected == true ? "annual" : "gold")
                sm.purchaseProduct(product: sub)
            } label: {
                Text("Subscribe")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .background(.green)
                    .cornerRadius(20)
            }
        }.onChange(of: sm.subscribed, perform: { value in
            presentationMode.wrappedValue.dismiss()
        })
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView(dc: DataController(), sm: StoreManager())
    }
}

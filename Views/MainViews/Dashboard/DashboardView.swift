//
//  DashboardView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI


struct DashboardView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State var navStack = NavigationPath()
    @State private var showingFilterSheet = false
    
    var body: some View {
            NavigationStack(path: $navStack) {
                ZStack {
                    ScrollView {
                        if !sm.monthlySub && !sm.annualSub {
                            Button {
                                showingFilterSheet = true
                            } label: {
                                PremiumBar()
                                    .padding(.horizontal)
                            }.sheet(isPresented: $showingFilterSheet){
                                SubscriptionView(dc: dc, sm: sm)
                            }
                        } // if subscribed
                        ZStack {
                            if !sm.monthlySub && !sm.annualSub {
                                VStack {
                                    Text("Get a personalised dashboard with TRL Pro")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                        .padding(.top, 40)
                                    Spacer()
                                } // vstack
                            }
                            
                        } // zstack
                        
                    }.navigationTitle("Dashboard")
                } // zstack
            } // navstack
    } // body
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(dc: DataController(), sm: StoreManager())
    }
}

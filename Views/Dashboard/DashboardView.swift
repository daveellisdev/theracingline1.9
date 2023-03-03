//
//  DashboardView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI


struct DashboardView: View {
    
    @ObservedObject var dc: DataController
    
    @State var navStack = NavigationPath()
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationStack(path: $navStack) {
            ScrollView {
                
                Button {
                    showingFilterSheet = true
                } label: {
                    PremiumBar()
                }.sheet(isPresented: $showingFilterSheet){
                    SubscriptionView()
                }
                
                if dc.favouriteSessionsWithinNextTwelveHours.count > 0 {
                    // only visible for races within the next 12 hours
                    RaceChart(dc: dc)
                } else {
                    GroupBox {
                        HStack {
                            Text("No Races in the next 12 hours")
                                .font(.caption)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                    }
                }
                
                if dc.favouriteLiveSessions.count > 0 {
                    // only visible for live events
                    LiveSessionsView(dc: dc)
                }
                
                if dc.favouriteSessionsWithinNextTwelveHoursButNotLive.count > 0 {
                    // only visible if series within the next 12 hours
                    UpNextSessionsView(dc: dc, sessions: dc.favouriteSessionsWithinNextTwelveHoursButNotLive, text: "next 12 hours")
                } else {
                    // visible at all times. Series within next 12 hours removed
                    UpNextSessionsView(dc: dc, sessions: dc.favouriteSessionsNextTenUpcomingButNotInTheNextTwelveHours, text: "next 10 sessions")
                }
                
//                RecommendedSeriesView()
                
            }.navigationTitle("Dasboard")
            .padding(.horizontal)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(dc: DataController())
    }
}

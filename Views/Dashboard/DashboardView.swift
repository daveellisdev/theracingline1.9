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
    
    var body: some View {
        NavigationStack(path: $navStack) {
            ScrollView {
                if dc.sessionsWithinNextTwelveHours.count > 0 {
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
                
                if dc.liveSessions.count > 0 {
                    LiveSessionsView(dc: dc)
                }
                
                if dc.sessionsWithinNextTwelveHoursButNotLive.count > 0 {
                    UpNextSessionsView(dc: dc, sessions: dc.sessionsWithinNextTwelveHoursButNotLive, text: "next 12 hours")
                } else {
                    UpNextSessionsView(dc: dc, sessions: dc.sessionsNextTenUpcomingButNotInProgress, text: "next 10 sessions")
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

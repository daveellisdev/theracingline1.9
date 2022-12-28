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
//                if dc.sessionsWithinNextTwelveHours.count > 0 {
                    RaceChart(dc: dc)

//                }
                
                if dc.liveSessions.count > 0 {
                    LiveSessionsView(dc: dc)
                }
                
                UpNextSessionsView()
                
                RecommendedSeriesView()
                
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

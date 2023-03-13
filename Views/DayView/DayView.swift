//
//  DayView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI

struct DayView: View {
    
    @ObservedObject var dc: DataController
    @State var navStack = NavigationPath()
    @State private var showingFilterSheet = false
    
    var body: some View {
        
        let sessions = dc.sessionsInProgressAndUpcoming
        
        NavigationStack(path: $navStack) {
//            if !dc.storeManager.subscribed {
//                Button {
//                    showingFilterSheet = true
//                } label: {
//                    GroupBox {
//                        PremiumBarSlim().padding(.horizontal)
//                    }
//                }.sheet(isPresented: $showingFilterSheet){
//                    SubscriptionView(dc: dc)
//                }
//            }
            List(sessions) { session in
                if session.isComplete() {
                    SessionRowExpired(dc: dc, session: session)
                } else {
                    NavigationLink(value: session) {
                        SessionRow(dc: dc, session: session)
                    }
                }
            }.navigationDestination(for: Session.self) { session in
                SessionView_OLD(dc: dc, session: session)
            }
            .navigationTitle("Sessions")
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dc: DataController())
    }
}

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
    
    var body: some View {
        
        let sessions = dc.sessions
        
        NavigationStack(path: $navStack) {
            List(sessions) { session in
                if session.sessionComplete() != nil && session.sessionComplete()! {
                    SessionRowExpired(dc: dc, session: session)
                } else {
                    NavigationLink(value: session) {
                        SessionRow(dc: dc, session: session)
                    }
                }
            }.navigationDestination(for: Session.self) { session in
                SessionView(dc: dc, session: session)
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

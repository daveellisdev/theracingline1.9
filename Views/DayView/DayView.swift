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
                NavigationLink(value: session) {
                    if session.sessionComplete! {
                        SessionRowExpired(dc: dc, session: session)
                    } else {
                        SessionRow(dc: dc, session: session)
                    }
                }
            }.navigationDestination(for: Session.self) { session in
                Text("Session Page")
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

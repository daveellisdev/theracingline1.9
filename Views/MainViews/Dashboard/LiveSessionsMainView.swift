//
//  LiveSessionsMainView.swift
//  theracingline
//
//  Created by Dave on 14/03/2023.
//

import SwiftUI

struct LiveSessionsMainView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    var body: some View {
        if dc.favouriteLiveSessions.count > 0 {
            HStack {
                Text("Live Sessions")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            ForEach(dc.favouriteLiveSessions) { session in
                let series = dc.getSeriesById(seriesId: session.seriesId)
                if series != nil {
                    NavigationLink(value: session) {
                        GroupBox {
                            SessionView(dc: dc, sm: sm, series: series!, session: session)
                        }
                    } // navlink
                } // if series not nil
            }.navigationDestination(for: Session.self) { session in
                SessionDetailsView(dc: dc, sm: sm, session: session)
            }
        } else {
            Text("No Live Sessions")
        }
    }
}

struct LiveSessionsMainView_Previews: PreviewProvider {
    static var previews: some View {
        LiveSessionsMainView(dc: DataController(), sm: StoreManager())
    }
}

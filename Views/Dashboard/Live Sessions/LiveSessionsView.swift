//
//  LiveSessionsView.swift
//  theracingline
//
//  Created by Dave on 27/12/2022.
//

import SwiftUI

struct LiveSessionsView: View {
    @ObservedObject var dc: DataController

    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    Text("Live Now")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                } // hstack
                
                ForEach(dc.liveSessions) { session in
                    LiveSessionRow(dc: dc, session: session)
                } // foreach
            } // vstack
        } // groupbox
    } // body
}

struct LiveSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        LiveSessionsView(dc: DataController())
    }
}

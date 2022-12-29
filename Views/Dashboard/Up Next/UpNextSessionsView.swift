//
//  UpNextSessionsView.swift
//  theracingline
//
//  Created by Dave on 27/12/2022.
//

import SwiftUI

struct UpNextSessionsView: View {
    @ObservedObject var dc: DataController
    var sessions: [Session]
    var text: String

    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    Text("Up Next")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Text(text)
                        .font(.caption)
                } // hstack
                ForEach(sessions) { session in
                    UpNextSessionRow(dc: dc, session: session)
                }
            } // vstack
        } // groupbox
    }
}

struct UpNextSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        UpNextSessionsView(dc: DataController(), sessions: [exampleSession, exampleSession2, exampleSession3], text: "Next 12 hours")
    }
}

//
//  SessionRow.swift
//  theracingline
//
//  Created by Dave on 14/11/2022.
//

import SwiftUI

struct SessionRow: View {
    
    let session: Session
    
    var body: some View {
        VStack {
            HStack {
                Text(session.seriesId)
                Spacer()
            }
            HStack {
                Text(session.session.sessionName)
                Spacer()
                if session.getDurationText != nil {
                    Text(session.getDurationText!)
                }
            }
            HStack {
                Text(session.raceStartTimeAsString())
                Spacer()
                Text(session.timeFromNow)
            }
        }
    }
}

struct SessionRow_Previews: PreviewProvider {
    static var previews: some View {
        SessionRow(session: exampleSession)
    }
}

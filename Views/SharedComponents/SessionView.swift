//
//  SessionView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct SessionView: View {
    
    let series: Series
    let session: Session
    let durationText: String?
    
    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    EventRowSeriesName(series: series, shortName: false)
                    Spacer()
                    Text(session.session.sessionName)
                }.padding(.bottom, -8)
                HStack {
                    Spacer()
                    if durationText != nil {
                        Text(durationText!)
                    }
                }
                HStack {
                    Image(systemName: "calendar").padding(.trailing, -4)
                    Text(session.raceStartDateAsString())
                    Image(systemName: "clock").padding(.trailing, -4)
                    Text(session.raceStartTimeAsString())
                    Spacer()
                    Text(session.timeFromNow())
                    Image(systemName: "clock").padding(.leading, -4)
                }
            }.font(.caption)
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(series: exampleSeries, session: exampleSession, durationText: nil)
    }
}

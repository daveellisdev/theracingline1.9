//
//  SessionView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct SessionView: View {
    
    @ObservedObject var dc: DataController

    let series: Series
    let session: Session
    let durationText: String?
    
    var body: some View {
        VStack {
            HStack {
                EventRowSeriesName(series: series, shortName: false)
                Spacer()
                Text(session.session.sessionName)
                    .fontWeight(.bold)
                if session.isInProgress() && dc.storeManager.subscribed {
                    LiveCircleView()
                }
            }.padding(.bottom, -2)
            HStack {
                Spacer()
                if durationText != nil && dc.storeManager.subscribed {
                    Text(durationText!)
                }
            }.padding(.bottom, 1)
            HStack {
                Image(systemName: "calendar").padding(.trailing, -4)
                Text(session.raceStartDateAsString())
                if dc.storeManager.subscribed {
                    Image(systemName: "clock").padding(.trailing, -4)
                    Text(session.raceStartTimeAsString())
                }
                Spacer()
                if dc.storeManager.subscribed {
                    Text(session.timeFromNow())
                    Image(systemName: "clock").padding(.leading, -4)
                }
            }.foregroundColor(.secondary)
        }.font(.caption)
            
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(dc: DataController(), series: exampleSeries, session: exampleSession, durationText: nil)
    }
}

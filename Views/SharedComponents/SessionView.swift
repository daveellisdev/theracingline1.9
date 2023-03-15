//
//  SessionView.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct SessionView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager

    let series: Series
    let session: Session
    
    var body: some View {
        
        let duration = session.getDurationText()
        VStack {
            HStack {
                EventRowSeriesName(series: series, shortName: false)
                Spacer()
                Text(session.session.sessionName)
                    .fontWeight(.bold)
                if session.isInProgress() && sm.subscribed {
                    LiveCircleView()
                }
            }.padding(.bottom, -2)
            HStack {
                Spacer()
                if duration != nil && sm.subscribed {
                    Text(duration!)
                }
            }.padding(.bottom, 1)
            HStack {
                Image(systemName: "calendar").padding(.trailing, -4)
                Text(session.raceStartDateAsString())
                if sm.subscribed {
                    Image(systemName: "clock").padding(.trailing, -4)
                    Text(session.raceStartTimeAsString())
                }
                Spacer()
                if sm.subscribed {
                    Text(session.timeFromNow())
                    Image(systemName: "clock").padding(.leading, -4)
                }
            }.foregroundColor(.secondary)
        }.font(.caption)
            
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(dc: DataController(), sm: StoreManager(), series: exampleSeries, session: exampleSession)
    }
}

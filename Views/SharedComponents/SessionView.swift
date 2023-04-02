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
        let tba = session.date.tba
        VStack {
            HStack {
                EventRowSeriesName(series: series, shortName: false)
                Spacer()
                Text(session.session.sessionName)
                    .fontWeight(.bold)
//                if session.isInProgress() && sm.subscribed {
//                    LiveCircleView()
//                }
            }.padding(.bottom, -2)
            HStack {
                Text(session.circuit.circuit)
                Spacer()
                if duration != nil && (sm.monthlySub || sm.annualSub) {
                    Text(duration!)
                }
            }.padding(.bottom, 1)
            HStack {
                Image(systemName: "calendar").padding(.trailing, -4)
                Text(session.raceStartDateAsString())
                if sm.monthlySub || sm.annualSub {
                    Image(systemName: "clock").padding(.trailing, -4)
                    Text(session.raceStartTimeAsString())
                }
                Spacer()
                
                if session.isComplete() {
                    Text("Complete")
                    Image(systemName: "checkmark.circle.fill").padding(.leading, -4)
                } else if sm.monthlySub || sm.annualSub {
                    if session.isInProgress() {
                        Text("In Progress")
                        LiveCircleView()
                    } else if tba == nil || (tba != nil && !tba!){
                        Text(session.timeFromNow())
                        Image(systemName: "clock").padding(.leading, -4)
                    }
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

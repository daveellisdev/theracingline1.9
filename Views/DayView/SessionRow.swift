//
//  SessionRow.swift
//  theracingline
//
//  Created by Dave on 14/11/2022.
//

import SwiftUI

struct SessionRow: View {
    
    @ObservedObject var dc: DataController
    let session: Session
    
    var body: some View {
        
        let series = dc.getSeriesById(seriesId: session.seriesId)
        if series != nil {
            VStack {
                HStack {
                    SessionRowSeriesName(series: series!, expired: false)
                    Spacer()
                    if session.isInProgress() {
                        LiveCircleView()
                    }
                }.padding(.bottom, -2)
                HStack {
                    Text(session.circuit.circuit)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                HStack {
                    Text(session.session.sessionName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    if session.getDurationText() != nil {
                        Text(session.getDurationText()!)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Image(systemName: "clock.arrow.2.circlepath")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .fontWeight(.bold)
                    }
                }
                HStack {
                    Text(session.raceStartDateAsString())
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fontWeight(.bold)
                    Text(session.raceStartTimeAsString())
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fontWeight(.bold)
                    Spacer()
                    Text(session.timeFromNow())
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fontWeight(.bold)
                    Image(systemName: "clock")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct SessionRow_Previews: PreviewProvider {
    static var previews: some View {
        SessionRow(dc: DataController(), session: exampleSession)
    }
}

//
//  EventViewSessionRow.swift
//  theracingline
//
//  Created by Dave on 06/11/2022.
//

import SwiftUI

struct EventViewSessionRow: View {
    
    var dc: DataController
    var session: Session
    
    var body: some View {
        
        let series = getSeriesById(id: session.seriesId)

        GroupBox() {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        if series != nil {
                            EventRowSeriesName(series: series!, shortName: false)
                        }
                    } // hstack
                    HStack {
                        Text(session.session.sessionName)
                            .font(.caption)
                        Spacer()
                        if let duration = session.getDurationText() {
                            Text(duration)
                                .font(.caption)
                            Image(systemName: "clock.arrow.2.circlepath")
                                .font(.caption2)
                        }
                    } // hstack
                    HStack {
                        Text(session.raceStartDateAsString())
                            .font(.caption)
                        if dc.storeManager.subscribed {
                            Text(session.raceStartTimeAsString())
                                                        .font(.caption)
                        }
                        
                        Spacer()
                        if dc.storeManager.subscribed {
                            Text(session.timeFromNow())
                                .font(.caption)
                            Image(systemName: "clock")
                                .font(.caption2)
                        }
                    } // hstack
                } // vstack
                Spacer()
            } // hstack
        } // groupbox
    }
    
    func getSeriesById(id: String) -> Series? {
        if let series = dc.series.first(where: { $0.seriesInfo.id == id }) {
            return series
        } else {
            return nil
        }
    }
}

struct EventViewSessionRow_Previews: PreviewProvider {
    static var previews: some View {
        EventViewSessionRow(dc: DataController(), session: exampleSession)
    }
}

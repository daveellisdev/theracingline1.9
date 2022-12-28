//
//  UpNextSessionRow.swift
//  theracingline
//
//  Created by Dave on 28/12/2022.
//

import SwiftUI

struct UpNextSessionRow: View {
    
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
                        Text(session.circuit.circuit)
                            .font(.caption)
                        Spacer()
                        if session.circuit.circuitLayout != nil {
                            Text(session.circuit.circuitLayout!)
                                .font(.caption)
                        }
                    }.padding(.top, 0) // hstack
                    HStack {
                        Text(session.session.sessionName)
                            .font(.caption)
                        Spacer()
                        if let duration = session.getDurationText() {
                            Text(duration)
                                .font(.caption)
                        }
                    } // hstack
                    HStack {
                        Text(session.raceStartDateAsString())
                            .font(.caption)
                        Text(session.raceStartTimeAsString())
                                                    .font(.caption)
                        Spacer()
                        Text(session.timeFromNow())
                            .font(.caption)
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

struct UpNextSessionRow_Previews: PreviewProvider {
    static var previews: some View {
        UpNextSessionRow(dc: DataController(), session: exampleSession)
    }
}

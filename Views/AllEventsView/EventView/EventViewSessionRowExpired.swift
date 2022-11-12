//
//  EventViewSessionRowExpired.swift
//  theracingline
//
//  Created by Dave on 10/11/2022.
//

import SwiftUI

struct EventViewSessionRowExpired: View {
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
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Completed")
                            .font(.caption)
                            .foregroundColor(.gray)
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

struct EventViewSessionRowExpired_Previews: PreviewProvider {
    static var previews: some View {
        EventViewSessionRowExpired(dc: DataController(), session: exampleSession)
    }
}

//
//  EventViewSessionRowLive.swift
//  theracingline
//
//  Created by Dave on 11/11/2022.
//

import SwiftUI

struct EventViewSessionRowLive: View {
    

    
    var dc: DataController
    var session: Session
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        let series = getSeriesById(id: session.seriesId)
        let duration = session.duration?.durationMinutes
        var timeComplete = (Date() - session.raceStartTime) / 60

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
                        if let duration = session.getDurationText {
                            Text(duration)
                                .font(.caption)
                        }
                    } // hstack
                    HStack {
                        Text(session.raceStartTimeAsString())
                            .font(.caption)
                        Spacer()
                        LiveCircleView()
                        Text("In Progress")
                            .font(.caption)
                    } // hstack
                    if duration != nil {
                        if timeComplete < Double(duration!) {
                            let timeLeftDouble = (Double(duration!) - timeComplete).rounded()
                            var timeLeft = Int(timeLeftDouble)
                            VStack {
                                HStack {
                                    Text("Approximate time remaining")
                                        .font(.caption)
                                    Spacer()
                                    Text("\(timeLeft) minutes")
                                        .font(.caption)
                                }
                                ProgressView(value: timeComplete, total: Double(duration!))
                                    .font(.caption)
                                    .onReceive(timer) { _ in
//                                        if timeComplete < Double(duration!) {
                                            timeComplete += 1
                                            timeLeft -= 1
//                                        }
                                    }
                            } // vstack
                            .padding(.top, 1)
                        } else {
                            VStack {
                                HStack {
                                    Text("Session Complete")
                                        .font(.caption)
                                    Spacer()
                                }
                                ProgressView(value: 100.0, total: 100.0)
                                    .font(.caption)
                            } // vstack
                        }
                    }
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

struct EventViewSessionRowLive_Previews: PreviewProvider {
    static var previews: some View {
        EventViewSessionRowLive(dc: DataController(), session: exampleSession3)
    }
}

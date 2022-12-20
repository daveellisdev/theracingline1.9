//
//  SessionViewSessionLive.swift
//  theracingline
//
//  Created by Dave on 16/11/2022.
//

import SwiftUI

struct SessionViewSessionLive: View {
    
    var dc: DataController
    var session: Session
    
    var body: some View {
        
        let duration = session.duration.durationMinutes
        let timeComplete = (Date() - session.raceStartTime()) / 60
        
        GroupBox {
            VStack {
                HStack {
                    Text(session.session.sessionName)
                    Spacer()
                    if session.getDurationText != nil {
                        Text(session.getDurationText()!)
                        Image(systemName: "clock.arrow.2.circlepath")
                            .font(.caption2)
                    }
                }
                HStack {
                    Text(session.circuit.circuit)
                    Spacer()
                    if session.circuit.circuitLayout != nil {
                        Text(session.circuit.circuitLayout!)
                    }
                }
                HStack {
                    Text(session.raceStartTimeAsString())
                    Spacer()
                    LiveCircleView()
                        
                    Text("In Progress")
                }.padding(.vertical, -10)
                if timeComplete < Double(duration) {
                    let timeLeftDouble = (Double(duration) - timeComplete).rounded()
                    let timeLeft = Int(timeLeftDouble)
                    VStack {
                        HStack {
                            Text("Approximate time remaining")
                                .font(.caption)
                            Spacer()
                            Text("\(timeLeft) minutes")
                                .font(.caption)
                        } // hstack
                        ProgressView(value: timeComplete, total: Double(duration))
                            .font(.caption)
                    } // vstack
                    .padding(.top, -2)
                } else {
                    VStack {
                        HStack {
                            Text("Session Complete")
                                .font(.caption)
                            Spacer()
                        } // hstack
                        ProgressView(value: 100.0, total: 100.0)
                            .font(.caption)
                    } // vstack
                } // if time complete else
            }.font(.caption)
        }
    }
}

struct SessionViewSessionLive_Previews: PreviewProvider {
    static var previews: some View {
        SessionViewSessionLive(dc: DataController(), session: exampleSession)
    }
}

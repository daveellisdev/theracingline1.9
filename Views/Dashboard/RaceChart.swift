//
//  RaceChart.swift
//  theracingline
//
//  Created by Dave on 18/11/2022.
//

import SwiftUI
import Charts
import SwiftDate

struct RaceChart: View {
    
    @ObservedObject var dc: DataController
    let sessions: [Session]
    
    var body: some View {
        
        
        
        GroupBox {
            VStack {
                HStack {
                    Text("Timelime")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack {
                    ScrollView(.horizontal) {
                        Chart {
                            ForEach(Array(sessions.enumerated()), id: \.element) { index, session in
                                
                                let seriesInfo = dc.getSeriesById(seriesId: session.seriesId)
                                
                                if seriesInfo != nil {
                                    BarMark(
                                        xStart: .value("Start", session.raceStartTime),
                                        xEnd: .value("End", session.raceEndTime),
                                        y: .value(seriesInfo!.seriesInfo.shortName, index),
                                        height: 30
                                    ) // barmark
                                    .foregroundStyle(by: .value("Series", seriesInfo!.seriesInfo.shortName))
                                    .annotation (
                                        position: .overlay,
                                        alignment: .leading
                                    ) {
                                        VStack(alignment: .leading) {
                                            Text(seriesInfo!.seriesInfo.shortName)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .colorInvert()
                                            Text(session.raceStartTimeAsString())
                                                .font(.caption2)
                                                .colorInvert()
                                        } // vstack
                                    } // barmark annotation
                                } // if seriesinfo not nil
                            } // foreach
                        } // chart
                        .chartYAxis(.hidden)
                        .chartLegend(.hidden)
                        .chartXScale(domain: Date()...Date()+12.hours)
                        .chartYScale(domain: 0...4)
                        .chartForegroundStyleScale([
                            "F1" : Color(red: 175 / 255, green: 34 / 255, blue: 34 / 255),
                            "F2" : Color(red: 22 / 255, green: 86 / 255, blue: 150 / 255),
                            "F3" : Color(red: 215 / 255, green: 90 / 255, blue: 90 / 255),
                            "WEC" : Color(red: 42 / 255, green: 147 / 255, blue: 172 / 255),
                            "IndyCar" : Color(red: 215 / 255, green: 90 / 255, blue: 90 / 255)
                        ])
                        .frame(width: 500, height: 200)
                        .padding()
                        
//                            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .clear]), startPoint: .leading, endPoint: .trailing))
                    }
                }
            }
        }
    }
}

struct RaceChart_Previews: PreviewProvider {
    static var previews: some View {
        RaceChart(dc: DataController(), sessions: [exampleSession, exampleSession2, exampleSession3])
    }
}

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
    let chartStartTime: Date
    
    var body: some View {
        
        GroupBox {
            VStack {
                HStack {
                    ScrollView(.horizontal) {
                        Chart {
                            ForEach(Array(sessions.enumerated()), id: \.offset) { index, session in

                                let seriesInfo = dc.getSeriesById(seriesId: session.seriesId)

                                if seriesInfo != nil {
                                    let red = Double(seriesInfo!.colourValues.dark[0])
                                    let green = Double(seriesInfo!.colourValues.dark[1])
                                    let blue = Double(seriesInfo!.colourValues.dark[2])
                                    let color = Color(red: red / 255, green: green / 255, blue: blue / 255)

                                    BarMark(
                                        xStart: .value("Start", calculateChartRaceStartTime(startDate: session.raceStartTime())),
                                        xEnd: .value("End", session.raceEndTime()),
                                        y: .value(seriesInfo!.seriesInfo.shortName, 1+index),
                                        height: 30
                                    ) // barmark
                                    .foregroundStyle(color)
                                    .annotation (
                                        position: .overlay,
                                        alignment: .leading
                                    ) {
                                        ChartAnnotation(seriesName: seriesInfo!.seriesInfo.shortName, raceTime: session.raceStartTimeAsString())
                                    } // barmark annotation
                                } // if seriesinfo not nil
                            } // foreach
                        } // chart
                        .chartYAxis(.hidden)
                        .chartLegend(.hidden)
                        .chartXScale(domain: chartStartTime...chartStartTime+24.hours)
                        .chartYScale(domain: 0...sessions.count)
                        .frame(width: 2000, height: CGFloat((sessions.count * 50) - 20))
                        .padding()
                    }
                }
            }
        }
    }
}

func calculateChartRaceStartTime(startDate: Date) -> Date {
    
    let now = Date() - 10.minutes
    
    if startDate < now {
        return now
    } else {
        return startDate
    }
}

struct RaceChart_Previews: PreviewProvider {
    static var previews: some View {
        RaceChart(dc: DataController(), sessions: [exampleSession, exampleSession2, exampleSession3], chartStartTime: Date())
    }
}

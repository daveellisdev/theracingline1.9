//
//  DashboardView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI
import Charts
import SwiftDate

struct DashboardView: View {
    var body: some View {
        ScrollView {
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
                                BarMark(
                                    xStart: .value("Start", Date()+4.hours),
                                    xEnd: .value("End", Date()+6.hours),
                                    y: .value("F1", 4),
                                    height: 30
                                )
                                .foregroundStyle(by: .value("Series", "F1"))
                                .annotation (
                                    position: .overlay,
                                    alignment: .leading
                                ) {
                                    VStack(alignment: .leading) {
                                        Text("F3")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .colorInvert()
                                        Text("18:00")
                                            .font(.caption2)
                                            .colorInvert()
                                    }
                                }
                                BarMark(
                                    xStart: .value("Start", Date()+2.hours),
                                    xEnd: .value("End", Date()+3.hours+30.minutes),
                                    y: .value("Value", 3),
                                    height: 30
                                )
                                .foregroundStyle(by: .value("Series", "F2"))
                                .annotation (
                                    position: .overlay,
                                    alignment: .leading
                                ) {
                                    VStack(alignment: .leading) {
                                        Text("F2")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .colorInvert()
                                        Text("16:00")
                                            .font(.caption2)
                                            .colorInvert()
                                    }
                                }
                                BarMark(
                                    xStart: .value("Start", Date()),
                                    xEnd: .value("End", Date()+1.hours),
                                    y: .value("Value", 2),
                                    height: 30
                                )
                                .foregroundStyle(by: .value("Series", "F3"))
                                .annotation (
                                    position: .overlay,
                                    alignment: .leading
                                ) {
                                    VStack(alignment: .leading) {
                                        Text("F3")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .colorInvert()
                                        Text("15:00")
                                            .font(.caption2)
                                            .colorInvert()
                                    }
                                    
                                }
                                BarMark(
                                    xStart: .value("Start", Date()+3.hours),
                                    xEnd: .value("End", Date()+9.hours),
                                    y: .value("Value", 1),
                                    height: 30
                                )
                                .symbolSize(1000)
                                .foregroundStyle(by: .value("Series", "WEC"))
                                .annotation (
                                    position: .overlay,
                                    alignment: .leading
                                ) {
                                    VStack(alignment: .leading) {
                                        Text("WEC")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .colorInvert()
                                        Text("17:00")
                                            .font(.caption2)
                                            .colorInvert()
                                    }
                                }
                            }
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
            GroupBox {
                HStack {
                    Text("Live Now")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            
            GroupBox {
                HStack {
                    Text("Up Next")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            GroupBox {
                HStack {
                    Text("You may like...")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
            }.navigationTitle("Dasboard")
        }.padding(.horizontal)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

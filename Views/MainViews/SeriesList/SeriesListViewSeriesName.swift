//
//  SeriesViewSeriesName.swift
//  theracingline
//
//  Created by Dave on 29/12/2022.
//

import SwiftUI

struct SeriesListViewSeriesName: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    let series: Series
    let hasLiveSession: Bool
    
    var body: some View {
        
        let darkR = Double(series.colourValues.dark[0])
        let darkG = Double(series.colourValues.dark[1])
        let darkB = Double(series.colourValues.dark[2])
        
        let lightR = Double(series.colourValues.light[0])
        let lightG = Double(series.colourValues.light[1])
        let lightB = Double(series.colourValues.light[2])

        let gradientStart = Color(red: darkR / 255, green: darkG / 255, blue: darkB / 255)
        let gradientEnd = Color(red: lightR / 255, green: lightG / 255, blue: lightB / 255)
        
        
        
        HStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(LinearGradient(
                      gradient: .init(colors: [gradientStart, gradientEnd]),
                      startPoint: .init(x: 0.5, y: 0),
                      endPoint: .init(x: 0.5, y: 0.6)
                    ))
                .frame(width: 8, height: 16)
            Text(series.seriesInfo.name)
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            if hasLiveSession && sm.subscribed {
                LiveCircleView()
            }
        }
    }
}

struct SeriesViewSeriesName_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListViewSeriesName(dc: DataController(), sm: StoreManager(), series: exampleSeries, hasLiveSession: true)
    }
}

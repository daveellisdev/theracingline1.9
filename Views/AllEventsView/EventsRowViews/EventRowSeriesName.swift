//
//  EventRowSeriesName.swift
//  theracingline
//
//  Created by Dave on 05/11/2022.
//

import SwiftUI

struct EventRowSeriesName: View {
    
    let series: Series
    let shortName: Bool
    
    var body: some View {
        let darkR = Double(series.colourValues.dark[0])
        let darkG = Double(series.colourValues.dark[1])
        let darkB = Double(series.colourValues.dark[2])
        
        let lightR = Double(series.colourValues.light[0])
        let lightG = Double(series.colourValues.light[1])
        let lightB = Double(series.colourValues.light[2])

        let gradientStart = Color(red: darkR / 255, green: darkG / 255, blue: darkB / 255)
        let gradientEnd = Color(red: lightR / 255, green: lightG / 255, blue: lightB / 255)
        
        RoundedRectangle(cornerRadius: 3)
            .fill(LinearGradient(
                  gradient: .init(colors: [gradientStart, gradientEnd]),
                  startPoint: .init(x: 0.5, y: 0),
                  endPoint: .init(x: 0.5, y: 0.6)
                ))
            .frame(width: 8, height: 16)
        if shortName {
            Text(series.seriesInfo.shortName)
                .font(.caption)
                .fontWeight(.bold)
        } else {
            Text(series.seriesInfo.name)
                .font(.caption)
                .fontWeight(.bold)
        }
        
    }
}

struct EventRowSeriesName_Previews: PreviewProvider {
    static var previews: some View {
        EventRowSeriesName(series: exampleSeries, shortName: true)
    }
}

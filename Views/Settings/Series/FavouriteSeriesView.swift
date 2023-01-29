//
//  FavouriteSeriesView.swift
//  theracingline
//
//  Created by Dave on 29/01/2023.
//

import SwiftUI

struct FavouriteSeriesView: View {
    
    @ObservedObject var dc: DataController
    
    var body: some View {
        
        let singleSeaters = dc.seriesSingleSeater
        let sportscars = dc.seriesSportscars
        let touringcars = dc.seriesTouringcars
        let stockcars = dc.seriesStockcars
        let rally = dc.seriesRally
        let bikes = dc.seriesBikes
        let others = dc.seriesOther
        
        ScrollView {
            GroupBox {
                Text("This tab defines which series apprear in the Dashboard. This allows you to keep your dashboard clean for the series you value the most.")
                    .font(.caption)
                    
                    
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
            Group {
                HStack {
                    Text("Single Seaters")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }
                ForEach(singleSeaters, id: \.self) { series in
                    SeriesToggle(dc: dc, type: .favourite, series: series)
                }
            }
            
            
            Group {
                HStack {
                    Text("Sportscars")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }
                ForEach(sportscars, id: \.self) { series in
                    SeriesToggle(dc: dc, type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Touring Cars")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }
                ForEach(touringcars, id: \.self) { series in
                    SeriesToggle(dc: dc, type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Stock Cars")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }
                ForEach(stockcars, id: \.self) { series in
                    SeriesToggle(dc: dc, type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Rally")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }
                ForEach(rally, id: \.self) { series in
                    SeriesToggle(dc: dc, type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Bikes")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }
                ForEach(bikes, id: \.self) { series in
                    SeriesToggle(dc: dc, type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Others")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }
                ForEach(others, id: \.self) { series in
                    SeriesToggle(dc: dc, type: .favourite, series: series)
                }
            }
        }
    }
}

struct FavouriteSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteSeriesView(dc: DataController())
    }
}

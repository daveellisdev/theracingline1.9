//
//  FavouriteSeriesView.swift
//  theracingline
//
//  Created by Dave on 29/01/2023.
//

import SwiftUI

struct FavouriteSeriesView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
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
                Text("This tab defines which series apprear in the Dashboard. This allows you to keep your dashboard clean for the series you value the most. If you mark a series as a favourite, it will also mark is as visible.")
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
                }.padding(.horizontal)
                ForEach(singleSeaters, id: \.self) { series in
                    SeriesToggle(dc: dc, sm: sm, isOn: getFavouriteFromSeries(series: series), type: .favourite, series: series)
                }
            }
            
            
            Group {
                HStack {
                    Text("Sportscars")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }.padding(.horizontal)
                ForEach(sportscars, id: \.self) { series in
                    SeriesToggle(dc: dc, sm: sm, isOn: getFavouriteFromSeries(series: series), type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Touring Cars")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }.padding(.horizontal)
                ForEach(touringcars, id: \.self) { series in
                    SeriesToggle(dc: dc, sm: sm, isOn: getFavouriteFromSeries(series: series), type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Stock Cars")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }.padding(.horizontal)
                ForEach(stockcars, id: \.self) { series in
                    SeriesToggle(dc: dc, sm: sm, isOn: getFavouriteFromSeries(series: series), type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Rally")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }.padding(.horizontal)
                ForEach(rally, id: \.self) { series in
                    SeriesToggle(dc: dc, sm:sm, isOn: getFavouriteFromSeries(series: series), type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Bikes")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }.padding(.horizontal)
                ForEach(bikes, id: \.self) { series in
                    SeriesToggle(dc: dc, sm:sm, isOn: getFavouriteFromSeries(series: series), type: .favourite, series: series)
                }
            }
            
            Group {
                HStack {
                    Text("Others")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }.padding(.horizontal)
                ForEach(others, id: \.self) { series in
                    SeriesToggle(dc: dc, sm:sm, isOn: getFavouriteFromSeries(series: series), type: .favourite, series: series)
                }
            }
        }
    }
    
    func getFavouriteFromSeries(series: Series) -> Bool {
        let seriesId = series.seriesInfo.id
        
        if let favourite = dc.favouriteSeries[seriesId] {
            return favourite
        } else {
            return true
        }
    }
}

struct FavouriteSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteSeriesView(dc: DataController(), sm: StoreManager())
    }
}

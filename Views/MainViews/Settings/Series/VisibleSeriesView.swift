//
//  VisibleSeriesView.swift
//  theracingline
//
//  Created by Dave on 29/01/2023.
//

import SwiftUI

struct VisibleSeriesView: View {
    
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
//            GroupBox {
//                Text("This tab defines which series apprear in the Day, Event and Series tabs.")
//                    .font(.caption)
//            }
//            .frame(maxWidth: .infinity)
//            .padding(.horizontal, 10)
            Group {
                HStack {
                    Text("Single Seaters")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 0)
                    Spacer()
                }.padding(.horizontal)
                ForEach(singleSeaters, id: \.self) { series in
                    SeriesToggle(dc: dc, sm:sm, isOn: getVisibilityFromSeries(series: series), type: .visible, series: series)
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
                    SeriesToggle(dc: dc, sm:sm, isOn: getVisibilityFromSeries(series: series), type: .visible, series: series)
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
                    SeriesToggle(dc: dc, sm:sm, isOn: getVisibilityFromSeries(series: series), type: .visible, series: series)
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
                    SeriesToggle(dc: dc, sm:sm, isOn: getVisibilityFromSeries(series: series), type: .visible, series: series)
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
                    SeriesToggle(dc: dc, sm:sm, isOn: getVisibilityFromSeries(series: series), type: .visible, series: series)
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
                    SeriesToggle(dc: dc, sm:sm, isOn: getVisibilityFromSeries(series: series), type: .visible, series: series)
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
                    SeriesToggle(dc: dc, sm:sm, isOn: getVisibilityFromSeries(series: series), type: .visible, series: series)
                }
            }
        }
    }
    
    func getVisibilityFromSeries(series: Series) -> Bool {
        let seriesId = series.seriesInfo.id
        
        if let visiblity = dc.visibleSeries[seriesId] {
            return visiblity
        } else {
            return true
        }
    }
}



struct VisibleSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        VisibleSeriesView(dc: DataController(), sm: StoreManager())
    }
}


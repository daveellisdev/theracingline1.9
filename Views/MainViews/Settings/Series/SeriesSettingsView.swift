//
//  SeriesSettingsView.swift
//  theracingline
//
//  Created by Dave on 29/01/2023.
//

import SwiftUI

struct SeriesSettingsView: View {
    
    @ObservedObject var dc: DataController
    @State var navStack: NavigationPath
    @State var selected = 0
    
    var body: some View {
        NavigationStack(path: $navStack) {
            VStack {
                Picker(selection: $selected, label: Text("Picker"), content: {
                    Text("Visible").tag(0)
                    Text("Favourites").tag(1)
                }).pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selected, perform: { value in
    //                data.simpleMenuHaptics()
                })
                
                if selected == 0 {
                    VisibleSeriesView(dc: dc)
                } else if selected == 1 {
                    FavouriteSeriesView(dc: dc)
                }
            } // vstack
            .navigationTitle("Series Selection")
        } // navstack
    } // body
}

struct SeriesSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesSettingsView(dc: DataController(), navStack: NavigationPath())
    }
}

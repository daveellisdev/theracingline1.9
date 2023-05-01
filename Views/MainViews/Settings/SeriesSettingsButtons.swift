//
//  SeriesSettingsButtons.swift
//  theracingline
//
//  Created by Dave on 01/05/2023.
//

import SwiftUI

struct SeriesSettingsButtons: View {
    
    @ObservedObject var dc: DataController
    let type: ToggleType

    
    var body: some View {
        HStack {
            Button(action: {
                switch type {
                case .visible:
                    dc.setAllSeriesAsVisible()
                    dc.saveSavedSettings()
                case .favourite:
                    dc.setAllAsFavourites()
                    dc.saveSavedSettings()
                case .notification:
                    dc.setAllAsNotified()
                    dc.saveSavedSettings()
                }
            }) {
                Text("All")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(.blue)
            .foregroundColor(.primary)
            .fontWeight(.bold)
            .cornerRadius(10)
            
            Button(action: {
                switch type {
                case .visible:
                    dc.setAllSeriesAsInvisible()
                case .favourite:
                    dc.setAllAsNotFavourites()
                case .notification:
                    dc.setNoNotified()
                }
            }) {
                Text("None")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(.blue)
            .foregroundColor(.primary)
            .fontWeight(.bold)
            .cornerRadius(10)
        }
    }
}

struct SeriesSettingsButtons_Previews: PreviewProvider {
    static var previews: some View {
        SeriesSettingsButtons(dc: DataController(), type: .visible)
    }
}

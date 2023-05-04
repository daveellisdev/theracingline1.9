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
            .background(LinearGradient(colors: [Color(red: 80 / 255, green: 177 / 255, blue: 217 / 255), Color(red: 77 / 255, green: 169 / 255, blue: 210 / 255)],startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(10)
            
            Button(action: {
                switch type {
                case .visible:
                    dc.setAllSeriesAsInvisible()
                    dc.saveSavedSettings()
                case .favourite:
                    dc.setAllAsNotFavourites()
                    dc.saveSavedSettings()
                case .notification:
                    dc.setNoNotified()
                    dc.saveSavedSettings()
                }
            }) {
                Text("None")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(LinearGradient(colors: [Color(red: 80 / 255, green: 177 / 255, blue: 217 / 255), Color(red: 77 / 255, green: 169 / 255, blue: 210 / 255)],startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(10)
        }.padding(.horizontal)
    }
}

struct SeriesSettingsButtons_Previews: PreviewProvider {
    static var previews: some View {
        SeriesSettingsButtons(dc: DataController(), type: .visible)
    }
}

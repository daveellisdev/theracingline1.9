//
//  ChartMainView.swift
//  theracingline
//
//  Created by Dave on 14/03/2023.
//

import SwiftUI

struct ChartMainView: View {
    
    @ObservedObject var dc: DataController
    @State var selected: Int
    let dailyArrays: [[Session]]

    var body: some View {
        
        GroupBox {
            Picker(selection: $selected, label: Text("Picker"), content: {
                if dc.mondayFavouriteSessions.count > 0 {
                    Text("M").tag(0)
                }
                if dc.tuesdayFavouriteSessions.count > 0 {
                    Text("T").tag(1)
                }
                if dc.wednesdayFavouriteSessions.count > 0 {
                    Text("W").tag(2)
                }
                if dc.thursdayFavouriteSessions.count > 0 {
                    Text("T").tag(3)
                }
                if dc.fridayFavouriteSessions.count > 0 {
                    Text("F").tag(4)
                }
                if dc.saturdayFavouriteSessions.count > 0 {
                    Text("S").tag(5)
                }
                if dc.sundayFavouriteSessions.count > 0 {
                    Text("S").tag(6)
                }
            }).pickerStyle(SegmentedPickerStyle())
            
            switch selected {
            case 0:
                if dc.mondayFavouriteSessions.count > 0 {
                    RaceChart(dc: dc, sessions: dc.mondayFavouriteSessions, chartStartTime: dc.mondayFavouriteSessions[0].raceStartTime())
                }
            case 1:
                if dc.tuesdayFavouriteSessions.count > 0 {
                    RaceChart(dc: dc, sessions: dc.tuesdayFavouriteSessions, chartStartTime: dc.tuesdayFavouriteSessions[0].raceStartTime())
                }
            case 2:
                if dc.wednesdayFavouriteSessions.count > 0 {
                    RaceChart(dc: dc, sessions: dc.wednesdayFavouriteSessions, chartStartTime: dc.wednesdayFavouriteSessions[0].raceStartTime())
                }
            case 3:
                if dc.thursdayFavouriteSessions.count > 0 {
                    RaceChart(dc: dc, sessions: dc.thursdayFavouriteSessions, chartStartTime: dc.thursdayFavouriteSessions[0].raceStartTime())

                }
            case 4:
                if dc.fridayFavouriteSessions.count > 0 {
                    RaceChart(dc: dc, sessions: dc.fridayFavouriteSessions, chartStartTime: dc.fridayFavouriteSessions[0].raceStartTime())

                }
            case 5:
                if dc.saturdayFavouriteSessions.count > 0 {
                    RaceChart(dc: dc, sessions: dc.saturdayFavouriteSessions, chartStartTime: dc.saturdayFavouriteSessions[0].raceStartTime())

                }
            case 6:
                if dc.sundayFavouriteSessions.count > 0 {
                    RaceChart(dc: dc, sessions: dc.sundayFavouriteSessions, chartStartTime: dc.sundayFavouriteSessions[0].raceStartTime())

                }
            default:
                if dc.sundayFavouriteSessions.count > 0 {
                    RaceChart(dc: dc, sessions: dc.sundayFavouriteSessions, chartStartTime: dc.sundayFavouriteSessions[0].raceStartTime())

                }
            }
        }
    }
}

struct ChartMainView_Previews: PreviewProvider {
    static var previews: some View {
        ChartMainView(dc: DataController(), selected: 0, dailyArrays: [[exampleSession]])
    }
}

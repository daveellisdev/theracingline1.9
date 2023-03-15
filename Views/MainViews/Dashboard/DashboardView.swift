//
//  DashboardView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI


struct DashboardView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State var navStack = NavigationPath()
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationStack(path: $navStack) {
            ScrollView {
                if !sm.subscribed {
                    Button {
                        showingFilterSheet = true
                    } label: {
                        PremiumBar()
                    }.sheet(isPresented: $showingFilterSheet){
                        SubscriptionView(dc: dc, sm: sm)
                    }
                }
                
                ZStack {
                    
                    VStack {
                        let dailyArrays = [
                            dc.mondayFavouriteSessions,
                            dc.tuesdayFavouriteSessions,
                            dc.wednesdayFavouriteSessions,
                            dc.thursdayFavouriteSessions,
                            dc.fridayFavouriteSessions,
                            dc.saturdayFavouriteSessions,
                            dc.sundayFavouriteSessions]
                        
                        let sortedDailyArray = dailyArrays.sorted { $0.count > $1.count }
                        if let index = dailyArrays.firstIndex{$0.count > 0} {
                            let defaultSelectionDay = dailyArrays[index].count
                            if sortedDailyArray[0].count > 0 {
//                                ChartMainView(dc: dc, selected: defaultSelectionDay, dailyArrays: dailyArrays)
                            }
                        }

                        LiveSessionsMainView(dc: dc, sm: sm)
                        
                        ThisWeeksSessionsMainView(dc: dc, sm: sm)
                    } // .blur(radius: 10)
//                    VStack {
//                        Text("Get a personalised dashboard with TRL Pro")
//                            .font(.title3)
//                            .fontWeight(.bold)
//                            .multilineTextAlignment(.center)
//                            .padding(.horizontal)
//                            .padding(.top, 40)
//                        Spacer()
//                    }
                }
            }.navigationTitle("Dashboard")
            .padding(.horizontal)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(dc: DataController(), sm: StoreManager())
    }
}

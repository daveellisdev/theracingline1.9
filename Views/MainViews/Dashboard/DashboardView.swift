//
//  DashboardView.swift
//  theracingline
//
//  Created by Dave on 26/10/2022.
//

import SwiftUI


struct DashboardView: View {
    
    @ObservedObject var dc: DataController
    
    @State var navStack = NavigationPath()
    @State private var showingFilterSheet = false
    @State var selected = 0
    
    var body: some View {
        NavigationStack(path: $navStack) {
            ScrollView {
                if !dc.storeManager.subscribed {
                    Button {
                        showingFilterSheet = true
                    } label: {
                        PremiumBar()
                    }.sheet(isPresented: $showingFilterSheet){
                        SubscriptionView(dc: dc)
                    }
                }
                GroupBox {
                    Text("CHART WITH TABS FOR EACH DAY THAT HAS SESSIONS")

                    Picker(selection: $selected, label: Text("Picker"), content: {
                        Text("M").tag(0)
                        Text("T").tag(1)
                        Text("W").tag(2)
                        Text("T").tag(3)
                        Text("F").tag(4)
                        Text("S").tag(5)
                        Text("S").tag(6)
                    }).pickerStyle(SegmentedPickerStyle())
                    
                    switch selected {
                    case 0:
                        Text("MONDAY")
                    case 1:
                        Text("TUESDAY")
                    case 2:
                        Text("WEDNESDAY")
                    case 3:
                        Text("THURSDAY")
                    case 4:
                        Text("FRIDAY")
                    case 5:
                        Text("SATURDAY")
                    case 6:
                        Text("SUNDAY")
                    default:
                        Text("SUNDAY")
                    }
                }
                Text("LIVE SESSIONS")
                Text("THIS WEEKENDS SESSIONS")
                
            }.navigationTitle("Dashboard")
            .padding(.horizontal)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(dc: DataController())
    }
}

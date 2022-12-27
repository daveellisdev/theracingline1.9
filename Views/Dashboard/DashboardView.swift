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
    
    var body: some View {
        NavigationStack(path: $navStack) {
            ScrollView {
                
                RaceChart(dc: dc)
                
                GroupBox {
                    HStack {
                        Text("Live Now")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                
                GroupBox {
                    HStack {
                        Text("Up Next")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                GroupBox {
                    HStack {
                        Text("You may like...")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
            }.navigationTitle("Dasboard")
            .padding(.horizontal)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(dc: DataController())
    }
}

//
//  LinkButtons.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct LinkButtons: View {
    
    @ObservedObject var dc: DataController
    @State private var showingOfficialLinks = false
    @State private var showingStreamingLinks = false
    
    let seriesIds: [String]
    
    var body: some View {
        HStack {
            Button(action: {
                showingOfficialLinks = true
            }) {
                Text("Streaming Links")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(LinearGradient(colors: [Color(red: 80 / 255, green: 177 / 255, blue: 217 / 255), Color(red: 77 / 255, green: 169 / 255, blue: 210 / 255)],startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(10)
            .sheet(isPresented: $showingOfficialLinks){
                LinksSheetView(dc: dc, linkType: .streaming, seriesIds: seriesIds)
            }
            
            Button(action: {
                showingStreamingLinks = true
            }) {
                Text("Official Links")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(LinearGradient(colors: [Color(red: 80 / 255, green: 177 / 255, blue: 217 / 255), Color(red: 77 / 255, green: 169 / 255, blue: 210 / 255)],startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(10)
            .sheet(isPresented: $showingStreamingLinks){
                LinksSheetView(dc: dc, linkType: .official, seriesIds: seriesIds)
            }
               
        }
    }
}

struct LinkButtons_Previews: PreviewProvider {
    static var previews: some View {
        LinkButtons(dc: DataController(), seriesIds: ["f1", "f2"])
    }
}

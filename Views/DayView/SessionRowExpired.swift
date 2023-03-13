//
//  SessionRowExpired.swift
//  theracingline
//
//  Created by Dave on 14/11/2022.
//
//
//import SwiftUI
//
//struct SessionRowExpired: View {
//    
//    @ObservedObject var dc: DataController
//    let session: Session
//    
//    var body: some View {
//        
//        let series = dc.getSeriesById(seriesId: session.seriesId)
//        if series != nil {
//            VStack {
//                HStack {
//                    SessionRowSeriesName(series: series!, expired: true)
//                    Spacer()
//                }.padding(.bottom, -2)
//
//                HStack {
//                    Text(session.session.sessionName)
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                    Spacer()
//                    Text("Session complete")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//        }
//    }
//}
//
//struct SessionRowExpired_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionRowExpired(dc: DataController(), session: exampleSession)
//    }
//}

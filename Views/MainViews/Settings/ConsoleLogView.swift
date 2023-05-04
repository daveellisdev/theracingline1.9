//
//  ConsoleLogView.swift
//  theracingline
//
//  Created by Dave on 31/03/2023.
//

import SwiftUI

struct ConsoleLogView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.black)
                ScrollView {
                    VStack(alignment: .leading) {
                        Group {
                            HStack {
                                Text("Developer Log")
                                    .fontWeight(.bold)
                                    .foregroundColor(.teal)
                                Spacer()
                                
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "x.circle")
                                }
                            }
                            HStack {
                                Text("You found the secret page!")
                            }
                            Divider()
                                .overlay(.teal)
                            HStack {
                                Text("IAP Information")
                                    .fontWeight(.bold)
                            }
                            HStack {
                                Text("Message: \(sm.message)")
                            }
                            HStack {
                                Text("monthySub: \(String(sm.monthlySub))")
                            }
                            HStack {
                                Text("annualSub: \(String(sm.annualSub))")
                            }
                            HStack {
                                Text("anySub: \(String(sm.subscribed))")
                            }
                        }
                        Group {
                            HStack {
                                Text("Message: \(sm.message2)")
                            }
                            HStack {
                                Text("Message: \(sm.message3)")
                            }
                            ForEach(sm.iaps, id: \.self) { item in
                                HStack {
                                    Text("IAP Name: \(item)")
                                }
                            }
                        }
                        Divider()
                            .overlay(.teal)
                        Group {
                            HStack {
                                Text("Stats")
                                    .fontWeight(.bold)
                            }
                            HStack {
                                Text("Number of series: \(dc.series.count)")
                            }
                            HStack {
                                Text("Number of events: \(dc.events.count)")
                            }
                            HStack {
                                Text("Number of sessions: \(dc.unfilteredSessions.count)")
                            }
                        }
                    }.padding()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
            }.frame(maxHeight: .infinity)
        }
        
    }
}

struct ConsoleLogView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleLogView(dc: DataController(), sm: StoreManager())
    }
}

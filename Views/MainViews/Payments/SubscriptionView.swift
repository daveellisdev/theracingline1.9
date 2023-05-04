//
//  SubscriptionView.swift
//  theracingline
//
//  Created by Dave on 25/02/2023.
//

import SwiftUI

struct SubscriptionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State private var annualSelected: Bool = true
    
    var body: some View {
        
        // menu selection
        VStack {
            HStack { // cancel button
                Button {
                    sm.restoreSubscriptionStatus()
                } label: {
                    Text("Restore")
                        .foregroundColor(.blue)
                }
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }.padding(.horizontal, 20)
                .padding(.top, 20)
                .onChange(of: sm.subscribed, perform: { value in
                    presentationMode.wrappedValue.dismiss()
                })
        }
        
        VStack {
            // scrollview

            ScrollView {
                Image("tRL-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(9)
                    .padding(.top, 20)
                Text("Your persoanlised motorsport calendar")
                    .fontWeight(.bold)
                Text("TRL Pro")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                Grid(alignment: .leading) {
                    GridRow {
                        Image(systemName: "stopwatch")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                            .padding(.trailing, 20)
                        VStack(alignment: .leading) {
                            Text("Race & session times")
                                .fontWeight(.bold)
                            Text("Start times for all sessions for all series")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }.padding(.horizontal, 20)
                        .padding(.top, 8)
                    GridRow {
                        Image(systemName: "app.badge")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                            .padding(.trailing, 20)
                        VStack(alignment: .leading) {
                            Text("Notifications")
                                .fontWeight(.bold)
                            Text("Customise notifications to the events and series you want, when you want")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }.padding(.horizontal, 20)
                        .padding(.top, 8)
                    GridRow {
                        Image(systemName: "square.dashed.inset.filled")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                            .padding(.trailing, 20)
                        VStack(alignment: .leading) {
                            Text("Widgets")
                                .fontWeight(.bold)
                            Text("Customise widgets for the series you want on your home screen")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }.padding(.horizontal, 20)
                        .padding(.top, 8)
                    GridRow {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                            .padding(.trailing, 20)
                        VStack(alignment: .leading) {
                            Text("Support a solo developer")
                                .fontWeight(.bold)
                            Text("This app is all made by a single independent developer. Your dedication to the app is what makes this possible.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }.padding(.horizontal, 20)
                        .padding(.top, 8)
                    GridRow {
                        Image(systemName: "flag.checkered")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                            .padding(.trailing, 20)
                        VStack(alignment: .leading) {
                            Text("More coming soon...")
                                .fontWeight(.bold)
                            Text("More features coming to the app soon.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }.padding(.horizontal, 20)
                        .padding(.top, 8)
                }.padding(.bottom, 8)
            }.background(Color(UIColor.secondarySystemBackground))
            
            VStack {
//                Spacer()
                // selection buttons
                SubscriptionSelectionView(dc: dc, sm: sm)
                    .ignoresSafeArea()
                    .padding(.bottom, -35)
                }
            }
            
        }
        
        
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView(dc: DataController(), sm: StoreManager())
    }
}

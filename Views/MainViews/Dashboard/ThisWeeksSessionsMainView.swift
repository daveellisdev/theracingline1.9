//
//  ThisWeeksSessionsMainView.swift
//  theracingline
//
//  Created by Dave on 14/03/2023.
//

import SwiftUI

struct ThisWeeksSessionsMainView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    var body: some View {
        
        let mondaySessions = dc.mondayFavouriteSessions
        let tuesdaySessions = dc.tuesdayFavouriteSessions
        let wednesdsySessions = dc.wednesdayFavouriteSessions
        let thursdaySessions = dc.thursdayFavouriteSessions
        let fridaySessions = dc.fridayFavouriteSessions
        let saturdaySessions = dc.saturdayFavouriteSessions
        let sundaySessions = dc.sundayFavouriteSessions

        
        if mondaySessions.count > 0 {
            Group {
                HStack {
                    Text("Monday")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                ForEach(mondaySessions) { session in
                    let series = dc.getSeriesById(seriesId: session.seriesId)
                    if series != nil {
                        NavigationLink(value: session) {
                            GroupBox {
                                SessionView(dc: dc, sm: sm, series: series!, session: session)
                            }
                        }.buttonStyle(PlainButtonStyle()) // navlink
                    }
                }.navigationDestination(for: Session.self) { session in
                    SessionDetailsView(dc: dc, sm: sm, session: session)
                }
            }
        }
        
        if tuesdaySessions.count > 0 {
            Group {
                HStack {
                    Text("Tuesday")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                ForEach(tuesdaySessions) { session in
                    let series = dc.getSeriesById(seriesId: session.seriesId)
                    if series != nil {
                        NavigationLink(value: session) {
                            GroupBox {
                                SessionView(dc: dc, sm: sm, series: series!, session: session)
                            }
                        }.buttonStyle(PlainButtonStyle()) // navlink
                    }
                }.navigationDestination(for: Session.self) { session in
                    SessionDetailsView(dc: dc, sm: sm, session: session)
                }
            }
        }
        
        if wednesdsySessions.count > 0 {
            Group {
                HStack {
                    Text("Wednesday")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                ForEach(wednesdsySessions) { session in
                    let series = dc.getSeriesById(seriesId: session.seriesId)
                    if series != nil {
                        NavigationLink(value: session) {
                            GroupBox {
                                SessionView(dc: dc, sm: sm, series: series!, session: session)
                            }
                        }.buttonStyle(PlainButtonStyle()) // navlink
                    }
                }.navigationDestination(for: Session.self) { session in
                    SessionDetailsView(dc: dc, sm: sm, session: session)
                }
            }
        }
        if thursdaySessions.count > 0 {
            Group {
                HStack {
                    Text("Thursday")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                ForEach(thursdaySessions) { session in
                    let series = dc.getSeriesById(seriesId: session.seriesId)
                    if series != nil {
                        NavigationLink(value: session) {
                            GroupBox {
                                SessionView(dc: dc, sm: sm, series: series!, session: session)
                            }
                        }.buttonStyle(PlainButtonStyle()) // navlink
                    }
                }.navigationDestination(for: Session.self) { session in
                    SessionDetailsView(dc: dc, sm: sm, session: session)
                }
            }
        }
        
        if fridaySessions.count > 0 {
            Group {
                HStack {
                    Text("Friday")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                ForEach(fridaySessions) { session in
                    let series = dc.getSeriesById(seriesId: session.seriesId)
                    if series != nil {
                        NavigationLink(value: session) {
                            GroupBox {
                                SessionView(dc: dc, sm: sm, series: series!, session: session)
                            }
                        }.buttonStyle(PlainButtonStyle()) // navlink
                    }
                }.navigationDestination(for: Session.self) { session in
                    SessionDetailsView(dc: dc, sm: sm, session: session)
                }
            }
        }
        
        if saturdaySessions.count > 0 {
            Group {
                HStack {
                    Text("Saturday")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                ForEach(saturdaySessions) { session in
                    let series = dc.getSeriesById(seriesId: session.seriesId)
                    if series != nil {
                        NavigationLink(value: session) {
                            GroupBox {
                                SessionView(dc: dc, sm: sm, series: series!, session: session)
                            }
                        }.buttonStyle(PlainButtonStyle()) // navlink
                    }
                }.navigationDestination(for: Session.self) { session in
                    SessionDetailsView(dc: dc, sm: sm, session: session)
                }
            }
        }
        if sundaySessions.count > 0 {
            Group {
                HStack {
                    Text("Sunday")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                ForEach(sundaySessions) { session in
                    let series = dc.getSeriesById(seriesId: session.seriesId)
                    if series != nil {
                        NavigationLink(value: session) {
                            GroupBox {
                                SessionView(dc: dc, sm: sm, series: series!, session: session)
                            }
                        }.buttonStyle(PlainButtonStyle()) // navlink
                    }
                }.navigationDestination(for: Session.self) { session in
                    SessionDetailsView(dc: dc, sm: sm, session: session)
                }
            }
        }
    }
}

struct ThisWeeksSessionsMainView_Previews: PreviewProvider {
    static var previews: some View {
        ThisWeeksSessionsMainView(dc: DataController(), sm: StoreManager())
    }
}

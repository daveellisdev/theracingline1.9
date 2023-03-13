//
//  LinksSheet.swift
//  theracingline
//
//  Created by Dave on 13/03/2023.
//

import SwiftUI

struct LinksSheetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dc: DataController
    
    let linkType: LinkType
    let seriesIds: [String]
    
    var body: some View {
        
        let title = linkType == .streaming ? "Streaming Links" : "Official Links"
        
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.blue)
                    }
                }.padding(.horizontal, 20)
                Text(title)
                    .fontWeight(.bold)
                
                if linkType == .official {
                    ForEach(seriesIds, id: \.self) { seriesId in
                        let series = dc.getSeriesById(seriesId: seriesId)
                        if series != nil {
                            GroupBox {
                                VStack {
                                    HStack{
                                        EventRowSeriesName(series: series!, shortName: false)
                                        Spacer()
                                    }
                                    LinkBox(linkType: .official, linkText: "Official Site", buttonText: "Official Site", linkUrl: series!.links.official)
                                    LinkBox(linkType: .official, linkText: "Live Timing", buttonText: "Live Timing", linkUrl: series!.links.timing)
                                }
                            }.padding(.horizontal)
                        }
                        
                    }
                } else if linkType == .streaming {
                    ForEach(seriesIds, id: \.self) { seriesId in
                        let series = dc.getSeriesById(seriesId: seriesId)
                        if series != nil {
                            GroupBox {
                                VStack {
                                    HStack {
                                        EventRowSeriesName(series: series!, shortName: false)
                                        Spacer()
                                    }
                                    if series!.streaming.count > 0 {
                                        ForEach(series!.streaming) { stream in
                                            LinkBox(linkType: .streaming, linkText: stream.name, buttonText: stream.country, linkUrl: stream.url)
                                        }
                                    } else {
                                        HStack {
                                            GroupBox {
                                                Text("No Offical Streams")
                                                    .font(.caption)
                                            }
                                        }
                                    }
                                    
                                }
                            }.padding(.horizontal)
                        }
                    }
                }
            } // vstack
            .padding(.top)
        } //  scrollview
    }
}

struct LinksSheet_Previews: PreviewProvider {
    static var previews: some View {
        LinksSheetView(dc: DataController(), linkType: .streaming, seriesIds: ["f1", "f2"])
    }
}

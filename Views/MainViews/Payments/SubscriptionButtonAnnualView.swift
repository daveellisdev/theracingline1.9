//
//  SubscriptionButtonAnnualView.swift
//  theracingline
//
//  Created by Dave on 26/02/2023.
//

import SwiftUI

struct SubscriptionButtonAnnualView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager

    let selected: Bool
    
    var body: some View {
        let sub = sm.getProductByName(productName: "annual")
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 70, height: 20)
                            .foregroundColor(.yellow)
                        HStack {
                            Text("Popular")
                                .font(.caption2)
                                .padding(.trailing, -5)
                                .foregroundColor(.black)
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(.black)
                        }
                    }.padding(.top, 10)
                        .padding(.trailing, 15)
                }
                Text("Annual")
                Spacer()
                Text("One month free trial")
                    .font(.caption)
                    .fontWeight(.bold)
                Text("\(sub.localizedPrice)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
                Text("billed annually")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("Two months free!")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            .overlay ( selected
                       ? RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 5)
                            .frame(width: 170)
                       : RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                            .frame(width: 170)
            )
        }.frame(width: 180, height: 160)
    }
}

struct SubscriptionButtonAnnualView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionButtonAnnualView(dc: DataController(), sm: StoreManager(), selected: true)
    }
}

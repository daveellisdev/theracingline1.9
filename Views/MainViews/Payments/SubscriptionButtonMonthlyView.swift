//
//  SubscriptionButtonMonthlyView.swift
//  theracingline
//
//  Created by Dave on 26/02/2023.
//

import SwiftUI

struct SubscriptionButtonMonthlyView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    let selected: Bool

    var body: some View {
        
        let sub = sm.getProductByName(productName: "gold")
        
        HStack {
            ZStack {
                VStack {
                    Spacer()
                    Text("Monthly")
                    Spacer()
                    Text("One month free trial")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("\(sub.localizedPrice)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    Spacer()
                    Text("billed monthly")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }.overlay ( selected
                            ? RoundedRectangle(cornerRadius: 10)
                                 .stroke(.blue, lineWidth: 5)
                                 .frame(width: 170)
                            : RoundedRectangle(cornerRadius: 10)
                                 .stroke(.gray, lineWidth: 1)
                                 .frame(width: 170)
                )
            }.frame(width: 150, height: 130)
        }
    }
}

struct SubscriptionButtonMonthlyView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionButtonMonthlyView(dc: DataController(), sm: StoreManager(), selected: false)
    }
}

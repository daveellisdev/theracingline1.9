//
//  SubscriptionButtonMonthlyView.swift
//  theracingline
//
//  Created by Dave on 26/02/2023.
//

import SwiftUI

struct SubscriptionButtonMonthlyView: View {
    let selected: Bool

    var body: some View {
        HStack {
            ZStack {
                VStack {
                    Spacer()
                    Text("Monthly")
                    Spacer()
                    Text("One month free trial")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("£2.99")
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
        SubscriptionButtonMonthlyView(selected: false)
    }
}

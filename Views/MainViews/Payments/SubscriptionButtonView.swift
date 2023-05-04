//
//  SubscriptionButtonMonthlyView.swift
//  theracingline
//
//  Created by Dave on 26/02/2023.
//

import SwiftUI
import StoreKit

struct SubscriptionButtonView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    let selected: Bool
    let sub: SKProduct
    let monthly: Bool

    var body: some View {
                
        let pricePerWeek = calculateWeeklyPrice(sub: sub, monthly: monthly)
        
        
        ZStack {
            
            
            HStack {
                VStack(alignment: .leading) {
                    Text(sub.localizedTitle)
                        .fontWeight(.bold)
                    Text("One month free trial")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }.padding()
                
                Spacer()
                Text("\(pricePerWeek) / week")
                    .font(.caption)
                    .padding()
            }.overlay ( selected
                        ? RoundedRectangle(cornerRadius: 10)
                             .stroke(.blue, lineWidth: 5)
                             
                        : RoundedRectangle(cornerRadius: 10)
                             .stroke(.gray, lineWidth: 1)
            ) // overlay
            
            if !monthly {
                HStack {
                    Spacer()
                    VStack {
                        HStack() {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption2)
                            Text("Most Popular")
                                .font(.caption2)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        }.padding(4).background(Color(.blue).clipShape(RoundedRectangle(cornerRadius:4)))
                        Spacer()
                    }.padding(.top, 12)
                    
                }.padding(.trailing, 8)
            }
        } // zstack
    }
    
    func calculateWeeklyPrice(sub: SKProduct, monthly: Bool) -> String {
        
        let price = sub.price
        let numberFormatter = NumberFormatter()
        let locale = sub.priceLocale
        
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = locale
        
        let pricePerWeek: Decimal
        if monthly {
            pricePerWeek = ((price as Decimal) * 12) / 52.2
        } else {
            pricePerWeek = (price as Decimal) / 52.2
        }
        
        return numberFormatter.string(from: pricePerWeek as NSNumber)!
        
    }
}

//struct SubscriptionButtonMonthlyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubscriptionButtonMonthlyView(dc: DataController(), sm: StoreManager(), selected: false)
//    }
//}

//
//  SubscriptionSelectionView.swift
//  theracingline
//
//  Created by Dave on 04/05/2023.
//

import SwiftUI

struct SubscriptionSelectionView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State private var annualSelected: Bool = true
    
    var body: some View {
        
        let monthlySub = sm.getProductByName(productName: "gold")
        let annualSub = sm.getProductByName(productName: "annual")
        
        VStack {
            Group {
                Text("Choose your plan")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                VStack {
                    Button {
                        annualSelected = true
                    } label: {
                            SubscriptionButtonView(dc: dc, sm: sm, selected: annualSelected, sub: annualSub, monthly: false).padding(.horizontal, 10)

                    }
                    
                    Button {
                        annualSelected = false
                    } label: {
                        SubscriptionButtonView(dc: dc, sm: sm, selected: !annualSelected, sub: monthlySub, monthly: true).padding(.horizontal, 10)
                    }
                }
                Text("Auto-renews")
                    .padding(.top, 5)
                    .font(.caption)
                    .foregroundColor(.gray)
                if annualSelected {
                    Text("\(annualSub.localizedPrice) / year")
    //                    .fontWeight(.bold)
                } else {
                    Text("\(monthlySub.localizedPrice) / month")
    //                    .fontWeight(.bold)
                }
                Group {
                    Button {
                        let sub = sm.getProductByName(productName: annualSelected == true ? "annual" : "gold")
                        sm.purchaseProduct(product: sub)
                    } label: {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .background(.green)
                    .cornerRadius(20)
                }.padding(.horizontal)
                    .padding(.bottom, 30)
            }
        }
        .background(Color(UIColor.systemBackground))
    }
}

//
//  PremiumBar.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct PremiumBar: View {
    
    static let gradientStart = Color(red: 0 / 255, green: 97 / 255, blue: 255 / 255)
    static let gradientEnd = Color(red: 69 / 255, green: 202 / 255, blue: 255 / 255)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(
                      gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                      startPoint: .leading,
                      endPoint: .trailing
                    ))
                .frame(height: 120)
            VStack {
                HStack {
                    Text("TRL Premium")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Text("Subscribe now for race times, notifications and more")
                        .font(.callout)
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Text("See more...")
                        .font(.caption)
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.top, 1)
            }.padding()
        }
    }
}

struct PremiumBar_Previews: PreviewProvider {
    static var previews: some View {
        PremiumBar()
    }
}

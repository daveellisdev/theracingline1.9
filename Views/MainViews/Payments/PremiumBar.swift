//
//  PremiumBar.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct PremiumBar: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.blue)
                .frame(height: 180)
            VStack {
                HStack {
                    Spacer()
                    Text("TRL Pro")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                Spacer()
                HStack {
                    Group {
                        Spacer()
                        Image(systemName: "play.display")
                        Spacer()
                        Image(systemName: "app.badge")
                        Spacer()
                    }
                    Group {
                        Image(systemName: "stopwatch")
                        Spacer()
                        Image(systemName: "square.dashed.inset.filled")
                        Spacer()
                        Image(systemName: "flag.checkered")
                        Spacer()
                    }
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                Spacer()
                HStack {
                    Text("A weekend dashboard, customisable notifications for your selected series, race times in your time zone, widgets and more.")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }.padding()
                .frame(height: 180)
        }
    }
}

struct PremiumBar_Previews: PreviewProvider {
    static var previews: some View {
        PremiumBar()
    }
}

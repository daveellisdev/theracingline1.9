//
//  Premium Bar Slim.swift
//  theracingline
//
//  Created by Dave on 06/03/2023.
//

import SwiftUI

struct PremiumBarSlim: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.blue)
                .frame(height: 80)
            VStack {
                HStack {
                    Spacer()
                    Text("TRL Pro")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
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
                    Text("Dashboard, notifications, race times, widgets and more.")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }.padding()
                .frame(height: 80)
        }
    }
}

struct Premium_Bar_Slim_Previews: PreviewProvider {
    static var previews: some View {
        PremiumBarSlim()
    }
}

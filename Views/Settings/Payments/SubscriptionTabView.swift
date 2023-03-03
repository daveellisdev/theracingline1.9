//
//  SubscriptionTabView.swift
//  theracingline
//
//  Created by Dave on 25/02/2023.
//

import SwiftUI

struct SubscriptionTabView: View {
    
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Spacer()
            Text("TRL Pro")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
            Spacer()
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)
            Text(description)
                .padding(.horizontal, 30)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.blue)
        .cornerRadius(20)
        .padding(.horizontal)
        
    }
}

struct SubscriptionTabView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionTabView(imageName: "app.badge", title: "Custom Notifications", description: "Notifications for the events and series you want, when you want them.")
    }
}

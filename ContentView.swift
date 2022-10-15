//
//  ContentView.swift
//  theracingline
//
//  Created by Dave on 15/10/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "car.fill")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("TRL2.0")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

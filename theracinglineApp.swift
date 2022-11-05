//
//  theracinglineApp.swift
//  theracingline
//
//  Created by Dave on 15/10/2022.
//

import SwiftUI

@main
struct theracinglineApp: App {
    
    @ObservedObject var dc = DataController.shared

    var body: some Scene {

        WindowGroup {
            ContentView(dc: dc)
        }
    }
}

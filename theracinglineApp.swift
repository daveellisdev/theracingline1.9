//
//  theracinglineApp.swift
//  theracingline
//
//  Created by Dave on 15/10/2022.
//

import SwiftUI

@main
struct theracinglineApp: App {
    var body: some Scene {
        
        let dataController = DataController()
        
        WindowGroup {
            ContentView(dataController: dataController)
        }
    }
}

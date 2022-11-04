//
//  DataController.swift
//  theracingline
//
//  Created by Dave on 25/10/2022.
//

import Foundation
import SwiftUI

class DataController: ObservableObject {
    
    @Published var series: [Series] = []
    @Published var circuits: [Circuit] = []
    @Published var events: [RaceEvent] = []
    
    init() {
        downloadData()
    }
    
    // DOWNLOAD DATA
    
    func downloadData() {
        print("DownloadDataRun")
        
        let keys = Keys()
        let key = keys.getKey()
        let binUrl = keys.getFullDataUrl()
        
        guard let url = URL(string: binUrl) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(key, forHTTPHeaderField: "X-ACCESS-KEY")
        request.addValue("false", forHTTPHeaderField: "X-BIN-META")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("API CALL FAILED")
                print(error!)
                return
            }

            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONDecoder().decode(FullDataDownload.self, from: data)
                
                DispatchQueue.main.async {
                    self.series = json.series
                    self.circuits = json.circuits
                    self.events = json.events
                    
                    print("Decoded")
                }
            } catch let jsonError as NSError {
                print(jsonError)
                print(jsonError.localizedDescription)
            }

        }.resume()
    } // DOWNLOADDATA
} // CONTROLER

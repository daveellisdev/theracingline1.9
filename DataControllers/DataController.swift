//
//  DataController.swift
//  theracingline
//
//  Created by Dave on 25/10/2022.
//

import Foundation
import SwiftUI

class DataController: ObservableObject {
    
    static var shared = DataController()
    
    @Published var series: [Series] = []
    @Published var seriesColors: [String:Color] = [:]
    @Published var circuits: [Circuit] = []
    @Published var events: [RaceEvent] = []
    @Published var sessions: [Session] = []
    
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
                    
                    // series
                    self.series = json.series
                    self.seriesColors = self.createColorDictionary(series: self.series)
                    
                    // circuits
                    self.circuits = json.circuits
                    
                    // events
                    var sortedEvents = json.events
                    sortedEvents.sort {$0.firstRaceDate < $1.firstRaceDate}
                    self.events = sortedEvents
                    
                    // sessions
                    self.sessions = self.createSessions(events: self.events)
                    
                    print("Decoded")
                }
            } catch let jsonError as NSError {
                print(jsonError)
                print(jsonError.underlyingErrors)
                print(jsonError.localizedDescription)
            }

        }.resume()
    } // DOWNLOADDATA
    
    func getSeriesById(seriesId: String) -> Series? {
        if let index = self.series.firstIndex(where: {$0.seriesInfo.id == seriesId}) {
            return series[index]
        } else {
            return nil
        }
    }
    
    func getCircuitByName(circuit: String) -> Circuit? {
        if let index = self.circuits.firstIndex(where: {$0.circuit == circuit}) {
            return circuits[index]
        } else {
            return nil
        }
    }
    
    func createColorDictionary(series: [Series]) -> [String:Color] {
        
        var seriesDictionary: [String:Color] = [:]
        for seriesDetails in series {
            
            let seriesName = seriesDetails.seriesInfo.shortName
            let seriesColors = Color(red: Double(seriesDetails.colourValues.dark[0] / 255), green: Double(seriesDetails.colourValues.dark[1] / 255), blue: Double(seriesDetails.colourValues.dark[2] / 255))
            
            seriesDictionary[seriesName] = seriesColors
        }
        return seriesDictionary
    }
    
    func createSessions(events: [RaceEvent]) -> [Session] {
        
        var sessions: [Session] = []
        for event in events {
            sessions.append(contentsOf: event.sessions)
        }
        sessions.sort { $0.raceStartTime < $1.raceStartTime }
        return sessions
    }
} // CONTROLER

//
//  SoundSettingsView.swift
//  theracingline
//
//  Created by Dave on 19/02/2023.
//

import SwiftUI
import AVFoundation


struct SoundSettingsView: View {
    
    @ObservedObject var dc: DataController
    
    @State var navStack: NavigationPath
    @State var audioPlayer: AVAudioPlayer!

    var body: some View {
        let activeSound = dc.applicationSavedSettings.notificationSound
        NavigationStack(path: $navStack) {
            VStack {
//                GroupBox {
//                    Text("Sound design by Sounds Good Soundworks.")
//                        .font(.caption)
//                }
                ForEach(soundFiles, id: \.self)  { soundFile in
                
                    Button(action: {
                        updateSelectedSound(soundName: soundFile.filename)
                    }) {
                        if soundFile.filename == activeSound {
                            SoundSettingRowView(content: soundFile.name, symbol: "checkmark")
                            
                        } else {
                            SoundSettingRowView(content: soundFile.name)
                        }
                    }
                    Divider().padding(.vertical, 4)

                }
            }.navigationTitle("Sounds")
            Spacer()
        }
    }
    
    func playSounds(soundName : String) {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: nil) else {
            fatalError("Unable to find \(soundName) in bundle")
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print(error.localizedDescription)
        }
        audioPlayer.play()
//            notifications.rebuildNotifications()
    }
    
    func updateSelectedSound(soundName: String) {
        dc.applicationSavedSettings.notificationSound = soundName
        dc.saveSavedSettings()
    }
}

struct Sound_SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SoundSettingsView(dc: DataController(), navStack: NavigationPath())
    }
}

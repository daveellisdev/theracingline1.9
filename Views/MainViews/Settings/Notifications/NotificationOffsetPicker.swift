//
//  NotificationOffsetPicker.swift
//  theracingline
//
//  Created by Dave on 19/02/2023.
//

import SwiftUI

struct NotificationOffsetPicker: View {
    
    @ObservedObject var dc: DataController
    
    @State var selectedDays: Int
    @State var selectedHours: Int
    @State var selectedMinutes: Int
    @State private var showingAlert = false
        
    var days = Array(0...6)
    var hours = Array(0...23)
    var minutes = Array(0...59)
    
    var body: some View {
        VStack {
            GroupBox {
                Text("The amount of time before the green flag that you want to receive a notifications")
                    .font(.caption)
            }
            HStack {
                Spacer()
                Text("Days")
                    .fontWeight(.bold)
                Spacer()
                Text("Hours")
                    .fontWeight(.bold)
                Spacer()
                Text("Minutes")
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                Picker("Days", selection: $selectedDays) {
                    ForEach(days, id: \.self) {
                        Text("\($0)")
                    }
                }.pickerStyle(.wheel)
                Picker("Hours", selection: $selectedHours) {
                    ForEach(hours, id: \.self) {
                        Text("\($0)")
                    }
                }.pickerStyle(.wheel)
                Picker("Minutes", selection: $selectedMinutes) {
                    ForEach(minutes, id: \.self) {
                        Text("\($0)")
                    }
                }.pickerStyle(.wheel)
            }
            Button(action: {
                dc.updateNotificationOffset(days: selectedDays, hours: selectedHours, minutes: selectedMinutes)
                dc.saveSavedSettings()
            }) {
                Text("Confirm Notification Offset")
            }.padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Notification Offset Confirmed"), dismissButton: .default(Text("Ok")))
                }
            Spacer()

       }
    }
}

struct NotificationOffsetPicker_Previews: PreviewProvider {
    static var previews: some View {
        NotificationOffsetPicker(dc: DataController(), selectedDays: 1, selectedHours: 1, selectedMinutes: 1)
    }
}

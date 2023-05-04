//
//  VersionView.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct VersionView: View {
    
    @ObservedObject var dc: DataController
    @ObservedObject var sm: StoreManager
    
    @State private var showingLogSheet = false

    var body: some View {
        GroupBox(label: SettingsLabelView(labelText: "Version", labelImage: "info.circle")) {
            Divider().padding(.vertical, 4)
            HStack {
                Button {
                    showingLogSheet = true
                } label: {
                    Text("Version 2.0")
                        .font(.caption)
                        .foregroundColor(.primary)
                    Spacer()
                }.sheet(isPresented: $showingLogSheet){
                    ConsoleLogView(dc: dc, sm: sm)
                }
                
            }
        } //GROUPBOX
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        VersionView(dc: DataController(), sm: StoreManager())
    }
}

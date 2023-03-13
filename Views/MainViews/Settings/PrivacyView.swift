//
//  PrivacyView.swift
//  theracingline
//
//  Created by Dave on 12/01/2023.
//

import SwiftUI

struct PrivacyView: View {
    
    @State var navStack: NavigationPath
    
    var body: some View {
        
        NavigationStack {
            GroupBox(label: SettingsLabelView(labelText: "Privacy", labelImage: "lock")) {
                Divider().padding(.vertical, 4)
                NavigationLink {
                    PrivacyPolicyView()
                } label: {
                    HStack {
                        Image(systemName: "lock.shield.fill")
                        Text("Privacy Policy")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                
                Divider().padding(.vertical, 4)

                NavigationLink {
                    TermsAndConditionsView()
                } label: {
                    HStack {
                        Image(systemName: "newspaper")
                        Text("T&Cs")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            } //GROUPBOX
            .foregroundColor(.primary)
        } // navstack
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView(navStack: NavigationPath())
    }
}

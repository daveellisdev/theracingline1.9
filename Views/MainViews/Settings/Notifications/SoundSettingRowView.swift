//
//  SoundSettingRowView.swift
//  theracingline
//
//  Created by Dave on 19/02/2023.
//

import SwiftUI

struct SoundSettingRowView: View {
        
    var content: String
    var symbol: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack {
                Text(content)
                    .foregroundColor(.primary)
                Spacer()
                if symbol != nil {
                    Image(systemName: symbol!)
                        .font(.caption)
                }
            }.padding(.horizontal)
            
        }
    }
}

struct SoundSettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SoundSettingRowView(content: "Sound")
    }
}

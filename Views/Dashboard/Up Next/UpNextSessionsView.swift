//
//  UpNextSessionsView.swift
//  theracingline
//
//  Created by Dave on 27/12/2022.
//

import SwiftUI

struct UpNextSessionsView: View {
    var body: some View {
        GroupBox {
            HStack {
                Text("Up Next")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
        }
    }
}

struct UpNextSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        UpNextSessionsView()
    }
}

//
//  RecommendedSeriesView.swift
//  theracingline
//
//  Created by Dave on 27/12/2022.
//

import SwiftUI

struct RecommendedSeriesView: View {
    var body: some View {
        GroupBox {
            HStack {
                Text("You may like...")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
        }
    }
}

struct RecommendedSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedSeriesView()
    }
}

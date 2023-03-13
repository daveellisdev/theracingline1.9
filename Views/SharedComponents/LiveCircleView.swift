//
//  LiveCircleView.swift
//  theracingline
//
//  Created by Dave on 12/11/2022.
//

import SwiftUI

struct LiveCircleView: View {
    
    @State private var liveColour: Color = Color(red: 0, green: 0.5, blue: 0)
    @State private var flashColour: Color = Color(red: 0, green: 1, blue: 0)
    
    var body: some View {
        
        Circle()
            .frame(width: 10)
            .foregroundColor(.white)
            .colorMultiply(flashColour)
    }
}

struct LiveCircleView_Previews: PreviewProvider {
    static var previews: some View {
        LiveCircleView()
    }
}

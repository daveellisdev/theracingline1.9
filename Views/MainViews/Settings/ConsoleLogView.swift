//
//  ConsoleLogView.swift
//  theracingline
//
//  Created by Dave on 31/03/2023.
//

import SwiftUI

struct ConsoleLogView: View {
    
    @ObservedObject var sm: StoreManager
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.black)
                VStack(alignment: .leading) {
                    Group {
                        HStack {
                            Text("The Nick Log")
                                .fontWeight(.bold)
                                .foregroundColor(.teal)
                        }
                        HStack {
                            Text("Message: \(sm.message)")
                            Spacer()
                        }
                        HStack {
                            Text("monthySub: \(String(sm.monthlySub))")
                            Spacer()
                        }
                        HStack {
                            Text("annualSub: \(String(sm.annualSub))")
                            Spacer()
                        }
                    }
                    Text("---------------------")
                    Group {
                        HStack {
                            Text("Message: \(sm.message2)")
                            Spacer()
                        }
                        HStack {
                            Text("Message: \(sm.message3)")
                            Spacer()
                        }
                        ForEach(sm.iaps, id: \.self) { item in
                            HStack {
                                Text("IAP Name: \(item)")
                                Spacer()
                            }
                        }
                    }
                    
                }.padding()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
            }.frame(maxHeight: .infinity)
        }
        
    }
}

struct ConsoleLogView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleLogView(sm: StoreManager())
    }
}

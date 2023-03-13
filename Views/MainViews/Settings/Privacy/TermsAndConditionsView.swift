//
//  TermsAndConditionsView.swift
//  theracingline
//
//  Created by Dave on 13/01/2023.
//

import SwiftUI

struct TermsAndConditionsView: View {
    var body: some View {
        ScrollView {
            VStack {
                GroupBox {
                    Text("1. Terms")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("By accessing theracingline app, you are agreeing to be bound by these terms of service, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing this app. The materials contained in this website are protected by applicable copyright and trademark law.")
                } //GROUPBOX
                GroupBox {
                    Group{
                        Text("2. Use Licence")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        Divider().padding(.vertical, 4)
                    }
                    Group {
                        Text("Permission is granted to temporarily download one copy of the materials (information or software) on TheRacingLine's website for personal, non-commercial transitory viewing only. This is the grant of a licence, not a transfer of title, and under this licence you may not:")
                        Divider().padding(.vertical, 4)
                        Text("modify or copy the materials;")
                        Divider().padding(.vertical, 4)
                        Text("attempt to decompile or reverse engineer any software contained on TheRacingLine's website;")
                        Divider().padding(.vertical, 4)
                        Text("remove any copyright or other proprietary notations from the materials; or")
                        Divider().padding(.vertical, 4)
                        Text("transfer the materials to another person or 'mirror' the materials on any other server.")
                        Group{
                            Divider().padding(.vertical, 4)
                            Text("This licence shall automatically terminate if you violate any of these restrictions and may be terminated by TheRacingLine at any time. Upon terminating your viewing of these materials or upon the termination of this licence, you must destroy any downloaded materials in your possession whether in electronic or printed format.")
                        }

                    }
                } //GROUPBOX
                GroupBox {
                    Text("3. Disclaimer")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("The materials on TheRacingLine's website are provided on an 'as is' basis. TheRacingLine makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.")
                    
                    Divider().padding(.vertical, 4)
                    Text("Further, TheRacingLine does not warrant or make any representations concerning the accuracy, likely results, or reliability of the use of the materials on its website or otherwise relating to such materials or on any sites linked to this site.")
                } //GROUPBOX
                GroupBox {
                    Text("4. Limitations")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("In no event shall TheRacingLine or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on TheRacingLine's website, even if TheRacingLine or a TheRacingLine authorised representative has been notified orally or in writing of the possibility of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of liability for consequential or incidental damages, these limitations may not apply to you.")
                } //GROUPBOX
                GroupBox {
                    Text("5. Accuracy of materials")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("The materials appearing on TheRacingLine's website could include technical, typographical, or photographic errors. TheRacingLine does not warrant that any of the materials on its website are accurate, complete or current. TheRacingLine may make changes to the materials contained on its website at any time without notice. However TheRacingLine does not make any commitment to update the materials.")
                } //GROUPBOX
                GroupBox {
                    Text("6. Links")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("TheRacingLine has not reviewed all of the sites linked to its website and is not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by TheRacingLine of the site. Use of any such linked website is at the user's own risk.")
                } //GROUPBOX
                GroupBox {
                    Text("7. Modifications")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("TheRacingLine may revise these terms of service for its website at any time without notice. By using this website you are agreeing to be bound by the then current version of these terms of service.")
                } //GROUPBOX
                GroupBox {
                    Text("8. Governing Law")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("These terms and conditions are governed by and construed in accordance with the laws of United Kingdom and you irrevocably submit to the exclusive jurisdiction of the courts in that State or location.")
                } //GROUPBOX
            }.padding(.horizontal, 20)
            .navigationBarTitle("Terms & Conditions")
        }
    }
}

struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView()
    }
}

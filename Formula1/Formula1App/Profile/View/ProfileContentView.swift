//
//  ProfileContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 21/3/23.
//

import SwiftUI

struct ProfileContentView: View {
    @EnvironmentObject var session: SessionStore
    @State private var selection = 1
    @State private var isLinksActive = false
    
    var body: some View {
        VStack {
            VStack {
                
                ProfileHeaderContentView(user: self.session.session)
                
                ProfileView()
                
            }
        }
        .accentColor(Color.black)
    }
}



struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContentView()
    }
}

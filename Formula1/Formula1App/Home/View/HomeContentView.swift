//
//  TopBarContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 14/3/23.
//

import SwiftUI

struct TopBarContentView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .foregroundColor(.black)
                ProfileView(authenticationViewModel: authenticationViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tint(.black)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct TopBarContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarContentView(authenticationViewModel: AuthenticationViewModel(service: NetworkServiceFactory.create()))
    }
}

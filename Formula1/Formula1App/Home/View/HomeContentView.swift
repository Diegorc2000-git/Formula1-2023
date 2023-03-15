//
//  HomeContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 14/3/23.
//

import SwiftUI

struct HomeContentView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    //@StateObject var linkViewModel: LinkViewModel = LinkViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    Text("Bienvenido \(authenticationViewModel.user?.email ?? "No user")")
                        .padding(.top, 32)
                    Spacer()
                    //LinkView(linkViewModel: linkViewModel)
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
//                ProfileView(authenticationViewModel: authenticationViewModel)
//                    .tabItem {
//                        Label("Profile", systemImage: "person.fill")
//                    }
            }

            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar {
                Button("Logout") {
                    authenticationViewModel.logout()
                }
            }
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(authenticationViewModel: AuthenticationViewModel())
    }
}

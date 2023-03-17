//
//  HomeContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 14/3/23.
//

import SwiftUI

struct HomeContentView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    Text("Bienvenido \(authenticationViewModel.user?.email ?? "No user")")
                        .padding(.top, 32)
                    Spacer()
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
            .navigationTitle("Home")
            .toolbar {
                Button("Logout") {
                    authenticationViewModel.logout()
                }
            }
        }
    }
}

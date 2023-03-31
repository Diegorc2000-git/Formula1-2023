//
//  ProfileView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack {
            LinkAccounts(authenticationViewModel: AuthenticationViewModel(service: NetworkServiceMockCoordinator.create()))
        }
    }
}

struct LinkAccounts: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var session: SessionStore
    @State var expandVerificationWithEmailForm: Bool = false
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    @State private var isLinksActive = false
    
    let columns = [
        GridItem(.flexible(minimum: 100), spacing: 20),
        GridItem(.flexible(minimum: 100), spacing: 20),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                VStack {
                    NavigationLink(destination: EditProfileContentView(session: self.session.session, profileViewModel: authenticationViewModel), isActive: $isLinksActive) {
                        Button(action: { self.isLinksActive = true }) {
                            Label(LocalizedKeys.Profile.profileEditProfile, image: ImageAndIconConstants.editIcon)
                                .fixedSize()
                                .foregroundColor(.black)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(Color(white: 0.95))
                .cornerRadius(10)
                .shadow(radius: 5)
                VStack {
                    Button(action: {
                        authenticationViewModel.logout()
                    }, label: {
                        Label(LocalizedKeys.Profile.profileLogOut, image: ImageAndIconConstants.logoutIcon)
                            .fixedSize()
                            .foregroundColor(.red)
                    })
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(Color(white: 0.95))
                .cornerRadius(10)
                .shadow(radius: 5)
                
            }
            .padding(.all, 50)
        }
    }
}

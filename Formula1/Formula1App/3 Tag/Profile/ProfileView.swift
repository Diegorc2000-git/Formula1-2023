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
            LinkAccounts(authenticationViewModel: AuthenticationViewModel(service: NetworkServiceFactory.create()))
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
    
    var body: some View {
        Form {
            Section {
                NavigationLink(destination: EditProfileContentView(session: self.session.session, profileViewModel: authenticationViewModel), isActive: $isLinksActive) {
                    Button(action: { self.isLinksActive = true }) {
                        Label(LocalizedKeys.Profile.profileEditProfile, image: "icon_editar")
                            .fixedSize()
                            .foregroundColor(.white)
                    }
                }
                Button(action: {
                    authenticationViewModel.logout()
                }, label: {
                    Label(LocalizedKeys.Profile.profileLogOut, image: "icon_logout")
                        .fixedSize()
                        .foregroundColor(.red)
                })
                .frame(maxWidth: .infinity)
            } header : {
                Text(LocalizedKeys.Profile.profileVinculatedAccountsTitle)
            }
        }
    }
}

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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
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
                Button(action: {
                    expandVerificationWithEmailForm.toggle()
                    print(LocalizedKeys.VinculatedAccounts.vinculateEmailPassword)
                }, label: {
                    Label(LocalizedKeys.Profile.profileVinculatedEmail, image: "icon_email")
                        .fixedSize()
                })
                .disabled(authenticationViewModel.isEmailAndPasswordLinked())
                if expandVerificationWithEmailForm {
                    Group {
                        Text(LocalizedKeys.VinculatedAccounts.vinculateEmailWithSessionAccount)
                            .tint(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.top, 2)
                            .padding(.bottom, 2)
                        TextField(LocalizedKeys.VinculatedAccounts.vinculateEnterEmail, text: $textFieldEmail)
                            .multilineTextAlignment(.center)
                        SecureField(LocalizedKeys.VinculatedAccounts.vinculateEnterPassword, text: $textFieldPassword)
                            .multilineTextAlignment(.center)
                        Button(LocalizedKeys.VinculatedAccounts.vinculateButton) {
                            authenticationViewModel.linkEmailAndPassword(email: textFieldEmail,
                                                                         password: textFieldPassword)
                        }
                        .buttonStyle(.bordered)
                        .tint(.gray)
                        .frame(maxWidth: .infinity)
                        if let messageError = authenticationViewModel.messageError {
                            Text(messageError)
                                .bold()
                                .font(.body)
                                .foregroundColor(.red)
                                .padding(.top, 20)
                        }
                    }
                }
                Button(action: {
                    authenticationViewModel.linkFacebook()
                }, label: {
                    Label(LocalizedKeys.Profile.profileVinculatedFacebook, image: "icon_facebook")
                        .fixedSize()
                        .foregroundColor(.white)
                })
                .disabled(authenticationViewModel.isFacebookLinked())
                NavigationLink(destination: EditProfileContentView(session: self.session.session), isActive: $isLinksActive) {
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
        .task {
            authenticationViewModel.getCurrentProvider()
        }
        .alert(authenticationViewModel.isAccountLinked ? LocalizedKeys.VinculatedAccounts.vinculateAlertAccountVinculated : LocalizedKeys.Errors.error,
               isPresented: $authenticationViewModel.showAlert) {
            Button(LocalizedKeys.Generic.ok) {
                print("Dismiss Alert")
                if authenticationViewModel.isAccountLinked {
                    expandVerificationWithEmailForm = false
                }
            }
        } message: {
            Text(authenticationViewModel.isAccountLinked ? LocalizedKeys.VinculatedAccounts.vinculateAlertAccountVinculatedSuccess : LocalizedKeys.VinculatedAccounts.vinculateAlertAccountVinculatedFailure)
        }
    }
}

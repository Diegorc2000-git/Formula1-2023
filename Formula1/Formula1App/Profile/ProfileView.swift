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
                    print("Vincular Email y Password")
                }, label: {
                    Label("Vincula Email", image: "icon_email")
                        .fixedSize()
                })
                .disabled(authenticationViewModel.isEmailAndPasswordLinked())
                if expandVerificationWithEmailForm {
                    Group {
                        Text("Vincula tu correo electrónico con la sesión que tienes actualmente iniciada.")
                            .tint(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.top, 2)
                            .padding(.bottom, 2)
                        TextField("Introduce tu correo electrónico", text: $textFieldEmail)
                            .multilineTextAlignment(.center)
                        SecureField("Introduce tu contraseña", text: $textFieldPassword)
                            .multilineTextAlignment(.center)
                        Button("Vincular") {
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
                    Label("Vincula Facebook", image: "icon_facebook")
                        .fixedSize()
                        .foregroundColor(.white)
                })
                .disabled(authenticationViewModel.isFacebookLinked())
                NavigationLink(destination: EditProfileContentView(session: self.session.session), isActive: $isLinksActive) {
                    Button(action: { self.isLinksActive = true }) {
                        Label("Editar Perfil", image: "icon_editar")
                            .fixedSize()
                            .foregroundColor(.white)
                    }
                }
                Button(action: {
                    authenticationViewModel.logout()
                }, label: {
                    Label("Cerrar Sesión", image: "icon_logout")
                        .fixedSize()
                        .foregroundColor(.red)
                })
                .frame(maxWidth: .infinity)
            } header : {
                Text("Vincula otras cuentas a la sesión actual")
            }
        }
        .task {
            authenticationViewModel.getCurrentProvider()
        }
        .alert(authenticationViewModel.isAccountLinked ? "¡Cuenta Vinculada!" : "Error",
               isPresented: $authenticationViewModel.showAlert) {
            Button("Aceptar") {
                print("Dismiss Alert")
                if authenticationViewModel.isAccountLinked {
                    expandVerificationWithEmailForm = false
                }
            }
        } message: {
            Text(authenticationViewModel.isAccountLinked ? "✅ Acabas de vincular tu cuenta" : "❌ Error al vincular la cuenta")
        }
    }
}

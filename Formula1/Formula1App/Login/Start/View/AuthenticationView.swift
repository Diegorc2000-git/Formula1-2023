//
//  AuthenticationView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import SwiftUI

enum AuthenticationSheetView: String, Identifiable {
    case register
    case login
    
    var id: String {
        return rawValue
    }
}

struct AuthenticationView: View {
    @EnvironmentObject var session: SessionStore
    
    func listen() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                TopBarContentView()
            } else {
                AuthenticationView2(authenticationViewModel: AuthenticationViewModel(service: NetworkServiceFactory.create()))
            }
        }.onAppear(perform: listen)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}

struct AuthenticationView2: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var authenticationSheetView: AuthenticationSheetView?
    
    var body: some View {
        VStack {
            Spacer()
            Text("Inicia Sesión")
                .font(.largeTitle)
                .bold()
                .underline()
            Image("icon_racing")
                .resizable()
                .frame(width: 150, height: 150)
            VStack {
                Button {
                    authenticationSheetView = .login
                } label: {
                    Label("Entrar con Email", image: "icon_email")
                        .fixedSize()
                }
                .tint(.blue)
                .foregroundColor(.black)
                .accessibilityIdentifier("emailButton")
                Button {
                    authenticationViewModel.loginFacebook()
                } label: {
                    Label("Entrar con Facebook", image: "icon_facebook")
                        .fixedSize()
                        .foregroundColor(.black)
                }
                .tint(.blue)
                .accessibilityIdentifier("FBButton")
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 60)
            if let messageError = authenticationViewModel.messageError {
                Text(messageError)
                    .bold()
                    .font(.body)
                    .foregroundColor(.red)
                    .padding(.top, 20)
            }
            Spacer()
            VStack {
                Button {
                    authenticationSheetView = .register
                } label: {
                    Text("¿No tienes cuenta?")
                    Text("Regístrate")
                        .underline()
                }
                .tint(.black)
                .accessibilityIdentifier("registerButton")
            }
        }.sheet(item: $authenticationSheetView) { sheet in
            switch sheet {
            case .register:
                RegisterEmailView(authenticationViewModel: authenticationViewModel)
            case .login:
                LoginEmailView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
    
}

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
                FirstScreenView(authenticationViewModel: AuthenticationViewModel(service: NetworkServiceFactory.create()))
            }
        }.onAppear(perform: listen)
    }
}

struct FirstScreenView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var authenticationSheetView: AuthenticationSheetView?
    
    var body: some View {
        VStack {
            Spacer()
            Text(LocalizedKeys.SignIn.loginButtonTitle)
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
                    Label(LocalizedKeys.SignIn.enterWithEmail, image: "icon_email")
                        .fixedSize()
                }
                .tint(.blue)
                .foregroundColor(.black)
                .accessibilityIdentifier("emailButton")
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 60)
            Spacer()
            VStack {
                Button {
                    authenticationSheetView = .register
                } label: {
                    Text(LocalizedKeys.SignIn.noAccount)
                    Text(LocalizedKeys.SignIn.signupButtonTitle)
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
        .accentColor(.black)
        .preferredColorScheme(.light)
    }
    
}

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
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var sheetManager: SheetManager

    func listen() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                TopBarContentView()
            } else {
                FirstScreenView(authenticationViewModel: AuthenticationViewModel(service: NetworkServiceMockCoordinator.create()))
            }
        }.onAppear(perform: listen)
            .sheet(isPresented: $sheetManager.isPresented, content: {
                sheetManager.getSheetContent()
                    .alert(isPresented: $alertManager.isPresented) {
                        alertManager.getAlert()
                    }
            })
            .alert(isPresented: $alertManager.isPresented) {
                alertManager.getAlert()
            }
            
    }
}

struct FirstScreenView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var authenticationSheetView: AuthenticationSheetView?
    @EnvironmentObject var sheetManager: SheetManager    
    @State private var presentSheet = false

    var body: some View {
        VStack {
            Spacer()
            Text(LocalizedKeys.SignIn.loginButtonTitle)
                .font(.largeTitle)
                .bold()
                .underline()
            Image(ImageAndIconConstants.raceIcon)
                .resizable()
                .frame(width: 150, height: 150)
            VStack {
                Button {
                    authenticationSheetView = .login
                    presentSheet = true
                } label: {
                    Label(LocalizedKeys.SignIn.enterWithEmail, image: ImageAndIconConstants.emailIcon)
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
                    presentSheet = true
                } label: {
                    Text(LocalizedKeys.SignIn.noAccount)
                    Text(LocalizedKeys.SignIn.signupButtonTitle)
                        .underline()
                }
                .tint(.black)
                .accessibilityIdentifier("registerButton")
            }
        }
        .onChange(of: presentSheet, perform: { newValue in
            if newValue {
                sheetManager.popSheet(model: SheetModelView(presentableContent: getSheetContent()))
                presentSheet = false
            }
        })
        .accentColor(.black)
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    private func getSheetContent() -> some View {
        switch authenticationSheetView {
        case .register:
            RegisterEmailView(authenticationViewModel: authenticationViewModel)
        case .login:
            LoginEmailView(authenticationViewModel: authenticationViewModel)
        case .none:
            EmptyView()
        }
    }
    
}

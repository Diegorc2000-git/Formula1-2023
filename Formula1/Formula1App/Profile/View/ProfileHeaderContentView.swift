//
//  ProfileHeaderContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 21/3/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeaderContentView: View {
    var user: User?
    @EnvironmentObject var session: SessionStore

    
    var body: some View {
        VStack {
            Text("Perfil")
                .font(.title)
                .padding(.top, 12)
            VStack {
                if user != nil {
                    WebImage(url: URL(string: user!.profileImage)!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 250, height: 250, alignment: .leading)
                }
                VStack(alignment: .leading) {
                    Text("Email: ").font(.headline).bold()
                    + Text(user?.email ?? "")
                    Text("Nombre: ").font(.headline).bold()
                    + Text((user?.name ?? "") + " " + (user?.surname ?? ""))
                }
                .padding(.trailing, 12)
            }
            VStack {
                Text("Biografia: ").font(.headline).bold()
                + Text(session.session?.bio ?? "")
            }
            .padding(.horizontal, 12.0)
            .frame(height: 100)
        }
        .padding(.bottom, 24)
        .padding(.top, 0.0)
        .edgesIgnoringSafeArea(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProfileHeaderContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderContentView()
    }
}

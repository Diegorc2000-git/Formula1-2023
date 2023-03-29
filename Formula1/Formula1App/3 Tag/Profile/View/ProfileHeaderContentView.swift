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
        HStack {
            VStack {
                if user != nil {
                    WebImage(url: URL(string: user!.profileImageUrl)!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 250, height: 250, alignment: .leading)
                }
                VStack(alignment: .leading) {
                    Text(LocalizedKeys.Profile.profileEmail).font(.headline).bold()
                    + Text(user?.email ?? "")
                    Text(LocalizedKeys.Profile.profileName).font(.headline).bold()
                    + Text(user?.username ?? "")
                }
                .padding(.trailing, 12)
            }
            VStack {
                Text(LocalizedKeys.Profile.profileBio).font(.headline).bold()
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

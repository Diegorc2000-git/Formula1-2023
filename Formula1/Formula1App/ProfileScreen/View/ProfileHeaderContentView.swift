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
        NavigationView {
            VStack {
                VStack {
                    ZStack(alignment: .top) {
                        Text(LocalizedKeys.Profile.profileTitle)
                            .bold()
                            .font(.largeTitle)
                        VStack {
                            if user != nil {
                                WebImage(url: URL(string: user!.profileImageUrl)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150 )
                                    .cornerRadius(80)
                            }
                        }
                        .padding(.top, 50)
                    }
                }
                VStack(spacing: 15) {
                    Text(user?.username ?? "")
                        .bold()
                        .font(.title)
                    Text(user?.email ?? "")
                        .font(.body)
                        .foregroundColor(.secondary)
                    Text(session.session?.bio ?? "")
                        .font(.body)
                        .bold()
                        .padding(.trailing, 24)
                        .padding(.leading, 24)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
   
}

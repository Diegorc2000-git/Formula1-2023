//
//  ARHomeView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import SwiftUI

struct ARHomeView: View {
    
    @Binding var showMenu: Bool
    @StateObject private var vm = CarsViewModel()

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack(alignment: .center, spacing: 50) {
                Button(action: {
                    showMenu.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                }
                .frame(width: 50, height: 50)
                .sheet(isPresented: $showMenu) {
                    ARMenuView(showMenu: $showMenu)
                }
                Button(action: {
                    ARContentView()
                }) {
                    Image("icon_volante")
                        .font(.system(size: 35))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.bottom, 50)
            .frame(maxWidth: 500)
            .padding(30)
            .background(Color.gray.opacity(0.25))
        }
    }
    
}

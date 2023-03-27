//
//  HomeSecondTagView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 27/3/23.
//

import SwiftUI

struct HomeSecondTagView: View {
    
    @StateObject var settings = CoordinatorSettings()
    
    let columns = [
        GridItem(.adaptive(minimum: 250) , spacing: 0)
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Información sobre F1")
                    .font(.title)
                    .padding(.leading, 24)
                    .padding(.top, 12)
                    .foregroundColor(.white)
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        NavigationLink(destination: ARHomeView().environmentObject(settings)) {
                            HStack(spacing: 24) {
                                Image("icon_ar")
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                Text("Abrir menú aumentado")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .aspectRatio(1, contentMode: .fill)
                        
                        NavigationLink(destination: ARHomeView()) {
                            HStack(spacing: 24) {
                                Image("icon_bandera")
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                Text("Abrir Circuitos")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .aspectRatio(1, contentMode: .fill)
                        
                        NavigationLink(destination: ARHomeView()) {
                            HStack(spacing: 24) {
                                Image("icon_casco")
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                Text("Abrir Pilotos")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .aspectRatio(1, contentMode: .fill)
                        
                        NavigationLink(destination: ARHomeView()) {
                            Text("Abrir Escuderias")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .aspectRatio(1, contentMode: .fill)
                    }
                    .padding(.trailing, 12)
                    .padding(.leading, 12)
                }
            }
            .background(
                Image("option")
                    .resizable()
                    .ignoresSafeArea()
            )
        }
        .accentColor(.black)
        .preferredColorScheme(.light)
    }
}

struct HomeSecondTagView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSecondTagView()
    }
}

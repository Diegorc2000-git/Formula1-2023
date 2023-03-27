//
//  ARContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 23/3/23.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct ControlView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            HStack(alignment: .center) {
                Button(action: {
                    showMenu.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 35))
                        .foregroundColor(.black)
                        .buttonStyle(PlainButtonStyle())
                }
                .frame(width: 50, height: 50)
                .sheet(isPresented: $showMenu) {
                    ARMenuView(showMenu: $showMenu)
                }
            }
            .frame(maxWidth: 500)
            .padding(.bottom, 30)
            .background(.white)
        }
        .navigationTitle("Menu AR")
    }
}

struct ARMenuView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("Menú")
                .font(.largeTitle)
                .padding(12)
            CategoryView(showMenu: $showMenu)
        }
        .foregroundColor(.black)
        .background(.white)
    }
}

struct CategoryView: View {
    
    @Binding var showMenu: Bool
    let models = ARViewModels()
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach(ARViewModelCategory.allCases, id: \.self) { category in
                if let categorias = models.get(category: category) {
                    GridView(showMenu: $showMenu, title: category.label, items: categorias)
                }
            }
        }
    }
}

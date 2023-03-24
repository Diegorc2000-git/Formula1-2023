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

struct ARMenuView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            CategoryView(showMenu: $showMenu)
        }
        .navigationTitle("Menú")
    }
}

struct CategoryView: View {
    
    @Binding var showMenu: Bool
    let models = Models()
    @StateObject private var vm = CarsViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach(ModelCategory.allCases, id: \.self) { category in
                if let categorias = models.get(category: category) {
                    ARCells(showMenu: $showMenu, title: category.label, items: categorias)
                }
            }
        }
    }
}

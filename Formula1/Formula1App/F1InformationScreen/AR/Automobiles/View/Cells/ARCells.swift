//
//  ARCells.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct GridView: View {
    
    @Binding var showMenu: Bool
    var title: String
    var items: [ARViewModel]
    let gridItem = [GridItem(.fixed(150))]
    @EnvironmentObject var settings: CoordinatorSettings
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .padding(.leading, 22)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItem, spacing: 10) {
                    ForEach(0..<items.count, id: \.self) { index in
                        let model = items[index]
                        Button(action: {
                            print("_Modelo Seleccionado: " + (model.name))
                            model.loadModel()
                            settings.selectedModel = model
                            showMenu.toggle()
                        }) {
                            Image(uiImage: model.thumbnail)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .background(Color.gray)
                                .cornerRadius(8.0)
                        }
                        .border(.black, width: 2)
                    }
                }
            }
            .padding(.horizontal, 23)
            .padding(.vertical, 10)
        }
    }
}

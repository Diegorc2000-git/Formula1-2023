//
//  Model.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import Foundation
import RealityKit
import Combine
import UIKit

enum ModelCategory: CaseIterable {

    case supercars
    case classiccars
    case motorbikes
    case accesories

    var label: String {
        get {
            switch self {
            case .supercars:
                return "Supercars"
            case .classiccars:
                return "Classiccars"
            case .motorbikes:
                return "Motorbikes"
            case .accesories:
                return "Accesories"
            }
        }
    }
}

class Model {
    
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scale: Float
    
    var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scale: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scale = scale
    }
    
    func loadModel() {
        let fileName = name + ".usdz"
        print(fileName)
        cancellable = ModelEntity.loadModelAsync(named: fileName)
            .sink(receiveCompletion: { loadCompletion in
                switch loadCompletion  {
                case .finished:
                    print("Modelo Cargado")
                    break
                case .failure(let error):
                    print("Error al cargar el modelo", error.localizedDescription)
                }
            }, receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scale
            })
    }
    
}

struct Models {
    
    var all: [Model] = []
    
    init() {
        all = [
            Model(name: "ford", category: .classiccars, scale: 3/100),// mientras mas pequeño/grande es el numero mas pequeña/grande es la imagen
            Model(name: "fida", category: .classiccars, scale: 3/100),
            Model(name: "zaz", category: .classiccars, scale: 3/100),
            Model(name: "ducati", category: .motorbikes, scale: 3/100),
            Model(name: "harley", category: .motorbikes, scale: 3/100),
            Model(name: "911", category: .supercars, scale: 3/100),
            Model(name: "uracan", category: .supercars, scale: 3/100),
            Model(name: "812", category: .supercars, scale: 3/100),
            Model(name: "urus", category: .supercars, scale: 3/100),
            Model(name: "aventador", category: .supercars, scale: 3/100),
            Model(name: "tyres", category: .accesories, scale: 3/100)
            
        ]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter({ $0.category == category })
    }
}

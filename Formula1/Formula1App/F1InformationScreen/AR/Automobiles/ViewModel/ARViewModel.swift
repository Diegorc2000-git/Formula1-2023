//
//  ARViewModel.swift
//  MenuAR
//
//  Created by Diego Rodriguez Casillas on 3/3/23.
//

import SwiftUI
import RealityKit
import Combine
import ARKit

enum ARViewModelCategory: CaseIterable {
    
    case f1
    case supercars
    
    var label: String {
        get {
            switch self {
            case .f1:
                return "F1"
            case .supercars:
                return "Supercars"
            }
        }
    }
}

class ARViewModel {
    
    var name: String
    var category: ARViewModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scale: Float
    
    var cancellable: AnyCancellable?
    
    init(name: String, category: ARViewModelCategory, scale: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scale = scale
    }
    
    func loadModel(){
        let filename = name + ".usdz"
        print(filename)
        cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                switch loadCompletion {
                case .failure(let error):
                    print("_Error al cargar el modelo", error.localizedDescription)
                case .finished:
                    print("_Modelo cargado correctamente")
                    break
                }
            }, receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scale
            })
    }
    
}

struct ARViewModels {
    
    var all: [ARViewModel] = []
    
    init() {
        all = [
            //Super Cars
            ARViewModel(name: ImageAndIconConstants.porsche, category: .supercars, scale: 3/100),
            ARViewModel(name: ImageAndIconConstants.mercedesAmgGt, category: .supercars, scale: 3/100),
            ARViewModel(name: ImageAndIconConstants.ferrari, category: .supercars, scale: 10000/100),
            //F1
            ARViewModel(name: ImageAndIconConstants.f1generic, category: .f1, scale: 3/100),
            ARViewModel(name: ImageAndIconConstants.f1astonMartin, category: .f1, scale: 3/100),
            ARViewModel(name: ImageAndIconConstants.f1mclaren, category: .f1, scale: 3/100),
            ARViewModel(name: ImageAndIconConstants.f1ferrari, category: .f1, scale: 3/100)
        ]
    }
    
    func get(category: ARViewModelCategory) -> [ARViewModel] {
        return all.filter({ $0.category == category })
    }
}

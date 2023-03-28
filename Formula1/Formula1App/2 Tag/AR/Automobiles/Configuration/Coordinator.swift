//
//  Coordinator.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 27/3/23.
//

import Foundation
import ARKit
import RealityKit
import FocusEntity
import Combine

class CoordinatorCustomARView: ARView {
    
    var focusEntity: FocusEntity?
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        self.focusEntity = FocusEntity(on: self, style: .classic(color: .yellow))
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("_init(coder:) has not been implemented")
    }
    
}

class CoordinatorSettings: ObservableObject {
    
    @Published var selectedModel: ARViewModel? {
        //Se activa cada vez que la varibale tiene un cambio
        willSet(newValue) {
            print("_Modelo seleccionado: " + (newValue?.name ?? ""))
        }
    }
    
    @Published var confirmedModel: ARViewModel? {
        //Se activa cada vez que la varibale tiene un cambio
        willSet(newValue) {
            guard let model = newValue else { return }
            print("_Confirmamos el modelo", model.name)
        }
    }
    
    var sceneObserved: Cancellable? // Sirve para poder cancelar la accion seleccionada
    
}


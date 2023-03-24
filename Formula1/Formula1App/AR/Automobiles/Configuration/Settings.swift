//
//  Settings.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import SwiftUI
import Combine

class Settings: ObservableObject {
    
    @Published var selectedModel: Model? {
        //Se activa cada vez que la varibale tiene un cambio
        willSet(newValue) {
            print("Selccionamos el modelo")
        }
    }
    
    @Published var confirmedModel: Model? {
        //Se activa cada vez que la varibale tiene un cambio
        willSet(newValue) {
            guard let model = newValue else { return }
            print("Confirmamos el modelo", model.name)
        }
    }
    
    var sceneObserved: Cancellable? // Sirve para poder cancelar la accion seleccionada
    
}

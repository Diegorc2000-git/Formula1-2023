//
//  Coordinator.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import Foundation
import RealityKit
import ARKit

class Coordinator {
    
    var arView: ARView?
    var mainScene: F1Cars.MainScene
    var vm: CarsViewModel
    
    init(vm: CarsViewModel) {
        self.vm = vm
        self.mainScene = try! F1Cars.loadMainScene()
    }
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        guard let arView = arView else { return }
        
        let location = recognizer.location(in: arView)
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = results.first {
            let anchor = AnchorEntity(raycastResult: result)
            guard let entity = mainScene.findEntity(named: vm.selectedcar) else { return }
            entity.position = SIMD3(0, 0, 0)
            
            anchor.addChild(entity)
            arView.scene.addAnchor(anchor)
        }
    }
}


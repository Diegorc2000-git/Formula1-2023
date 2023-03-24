//
//  ARCoordinator.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 23/3/23.
//

import Foundation
import RealityKit
import ARKit

class Coordinator: NSObject, ARSessionDelegate {
    
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

            let arAnchor = ARAnchor(name: "f1Anchor", transform: result.worldTransform)

            let anchor = AnchorEntity(anchor: arAnchor)
            guard let entity = mainScene.findEntity(named: vm.selectedcar) else { return }
            entity.position = SIMD3(0, 0, 0)
            
            arView.session.add(anchor: arAnchor)
            anchor.addChild(entity)
            arView.scene.addAnchor(anchor)
        }
    }
    
    func clearWorldMap() {
        
        guard let arView = arView else { return }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "f1cars")
        userDefaults.synchronize()
    }
    
}

//
//  ARView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 23/3/23.
//

import Foundation
import RealityKit
import ARKit

extension ARView: ARCoachingOverlayViewDelegate {
    
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.session
        coachingOverlay.delegate = self
        self.addSubview(coachingOverlay)
    }
    
    private func addVirtualObjects() {
        
        let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.3), materials: [SimpleMaterial(color: .green, isMetallic: true)])
        
        guard let anchor = self.scene.anchors.first(where: { $0.name == "Plane Anchor" }) else {
            return
        }
        
        anchor.addChild(box)
        
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        addVirtualObjects()
    }
    
}

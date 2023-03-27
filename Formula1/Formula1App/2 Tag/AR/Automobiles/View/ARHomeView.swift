//
//  ARHomeView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import SwiftUI
import RealityFoundation
import RealityKit
import FocusEntity

struct ARHomeView: View {
    
    @State private var showMenu = false
    @EnvironmentObject var settings: CoordinatorSettings
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARController()
            if settings.selectedModel == nil {
                ControlView(showMenu: $showMenu)
            } else {
                CameraView()
            }
        }
    }
}

struct ARController: UIViewRepresentable {
    
    @EnvironmentObject var settings: CoordinatorSettings
    
    func makeUIView(context: Context) -> CoordinatorCustomARView {
        let arView = CoordinatorCustomARView(frame: .zero)
        
        settings.sceneObserved = arView.scene.subscribe(to: SceneEvents.Update.self, { event in
            sceneUpdate(arView: arView)
        })
        return arView
    }
    
    func updateUIView(_ uiView: CoordinatorCustomARView, context: Context) {}
    
    func sceneUpdate(arView: CoordinatorCustomARView) {
        arView.focusEntity?.isEnabled = settings.selectedModel != nil
        if let confirmModel = settings.confirmedModel, let modelEntity = confirmModel.modelEntity {
            plane(modelEntity: modelEntity, arView: arView)
            settings.confirmedModel = nil
        }
    }
    
    func plane(modelEntity: ModelEntity, arView: ARView) {
        let clonedEntity = modelEntity.clone(recursive: true)
        clonedEntity.generateCollisionShapes(recursive: true)
        
        arView.installGestures([.all], for: clonedEntity) // para poder mover y girar el objeto
        
        let anchorEntity = AnchorEntity(plane: .any) // Para anclarlo
        anchorEntity.addChild(clonedEntity)
        arView.scene.addAnchor(anchorEntity)
    }
    
}

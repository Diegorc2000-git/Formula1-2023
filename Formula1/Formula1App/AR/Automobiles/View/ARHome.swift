//
//  ARHome.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import SwiftUI
import RealityFoundation
import RealityKit
import FocusEntity //El packete añadido

struct ARHome: View {
    
    @State private var showMenu = false
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARController()
            if settings.selectedModel == nil {
                ARHomeView(showMenu: $showMenu)
            } else {
                CameraView()
            }
        }
    }
}

struct CameraView: View {
    
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            CameraButton(icon: "xmark.circle.fill") {
                settings.selectedModel = nil
            }
            Spacer()
            CameraButton(icon: "checkmark.circle.fill") {
                settings.confirmedModel = settings.selectedModel
                settings.selectedModel = nil
            }
            Spacer()
                .padding(.bottom, 50)
        }
        .padding(.bottom, 50)
    }
}

struct CameraButton: View {
    
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 75, height: 75)
    }
}

struct ARController: UIViewRepresentable {
    
    @EnvironmentObject var settings: Settings
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero)
        
        settings.sceneObserved = arView.scene.subscribe(to: SceneEvents.Update.self, { event in
            sceneUpdate(arView: arView)
            
        })
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        
    }
    
    func sceneUpdate(arView: CustomARView) {
        arView.focusEntity?.isEnabled = settings.selectedModel != nil
        if let confirmModel = settings.confirmedModel, let modelEntity = confirmModel.modelEntity {
            plane(modelEntity: modelEntity, arView: arView)
            settings.confirmedModel = nil
        }
    }
    
    func plane(modelEntity: ModelEntity, arView: ARView) {
        let clonedEntity = modelEntity.clone(recursive: true)
        clonedEntity.generateCollisionShapes(recursive: true)
        
        arView.installGestures([.rotation, .translation], for: clonedEntity) // para poder mover y girar el objeto
        
        let anchorEntity = AnchorEntity(plane: .any) // Para anclarlo
        anchorEntity.addChild(clonedEntity)

        arView.scene.addAnchor(anchorEntity)
    }
    
}

class CustomARView: ARView {
    
    var focusEntity: FocusEntity?
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        focusEntity = FocusEntity(on: self, focus: .classic)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

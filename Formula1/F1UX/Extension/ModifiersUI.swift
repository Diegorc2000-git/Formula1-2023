//
//  ModifiersUI.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 31/3/23.
//

import SwiftUI
import RealityKit
import ARKit

struct TextFieldModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.gray.opacity(0.2))
            .cornerRadius(5.0)
            .padding()
    }
}

struct FormField: View {
    
    @Binding var value: String
    var placeHolder: String
    var isSecure = false
    
    var body: some View {
        Group {
            HStack {
                Group {
                    if isSecure {
                        SecureField(placeHolder, text: $value)
                    } else {
                        TextField(placeHolder, text: $value)
                    }
                }
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .keyboardType(.emailAddress)
            }
        }
    }
}

struct ButtonModifiers: ViewModifier {
   
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 20)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .bold))
            .background(Color.black)
            .cornerRadius(5.0)
            .padding()
    }
}

extension ARView: ARCoachingOverlayViewDelegate {
    
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .verticalPlane
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

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var pickerImage: Image?
    @Binding var showImagePicker: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[.editedImage] as! UIImage
            parent.pickerImage = Image(uiImage: uiImage)
            
            if let mediaData = uiImage.jpegData(compressionQuality: 0.5) {
                parent.imageData = mediaData
            }
            parent.showImagePicker = false
        }
    }
}

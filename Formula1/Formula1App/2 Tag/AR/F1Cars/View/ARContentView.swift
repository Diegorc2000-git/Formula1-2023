//
//  ARContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ARContentView : View {
    
    @Binding var showMenu: Bool
    @StateObject var settings = Settings()
    @StateObject private var vm = CarsViewModel()
    let cars = ["mclaren", "ferrari", "astonmartin", "redbull"]
    
    var body: some View {
        VStack {
            ARViewContainer(vm: vm).edgesIgnoringSafeArea(.all)
            Button(action: {
                showMenu.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 50, height: 50)
            .sheet(isPresented: $showMenu) {
                ARHome()
                    .environmentObject(settings)
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(cars, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding()
                            .border(.white, width: vm.selectedcar == name ? 1.0: 0.0)
                            .onTapGesture {
                                vm.selectedcar = name
                            }
                    }
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    let vm: CarsViewModel
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        session.run(config)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.tapped)))
        context.coordinator.arView = arView
        arView.addCoachingOverlay()
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(vm: vm)
    }
}

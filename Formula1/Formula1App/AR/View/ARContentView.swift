//
//  ARContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 23/3/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ARContentView : View {
    
    @StateObject private var vm = CarsViewModel()
    let cars = ["mclaren", "ferrari", "astonmartin", "redbull"]
    
    var body: some View {
        VStack {
            ARViewContainer(vm: vm).edgesIgnoringSafeArea(.all)
            HStack {
                Button("Limpiar") {
                    vm.onClear()
                }.buttonStyle(.bordered)
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
                .border(.white)
                .padding(.bottom, 75)
            }
            .background(.black)
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
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.name = "Plane Anchor"
        session.run(config)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.tapped)))
        context.coordinator.arView = arView
        arView.addCoaching()
        
        vm.onClear = {
            context.coordinator.clearWorldMap()
        }
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(vm: vm)
    }
}

#if DEBUG
struct ARContentView_Previews: PreviewProvider {
    static var previews: some View {
        ARContentView()
    }
}
#endif

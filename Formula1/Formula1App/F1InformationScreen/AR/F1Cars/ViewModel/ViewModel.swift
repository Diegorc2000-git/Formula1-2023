//
//  ViewModel.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import Foundation
import RealityKit
import ARKit

class CarsViewModel: ObservableObject {
    @Published var selectedcar: String = ""
    var onSave: () -> Void = { }
    var onClear: () -> Void = { }
    @Published var isSaved: Bool = false
}

extension ARView {
    
    func addCoachingOverlay() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.session
        self.addSubview(coachingOverlay)
    }
    
}

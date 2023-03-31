//
//  SheetManager.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 30/3/23.
//

import Foundation
import SwiftUI

class SheetManager: ObservableObject {
    @Published var isPresented: Bool
    @Published var model: SheetModelView
    
    init(isPresented: Bool = false, model: SheetModelView = SheetModelView()) {
        self.isPresented = isPresented
        self.model = model
    }
    
    func popSheet(
        model: SheetModelView
    ) {
        self.model = model
        self.isPresented = true
    }
    
    @ViewBuilder
    func getSheetContent() -> some View {
        self.model.presentableContent
    }   
}

struct SheetModelView {
    var presentableContent: AnyView
    
    init(presentableContent: some View) {
        self.presentableContent = AnyView(presentableContent)
    }
    
    init() {
        self.presentableContent = AnyView(EmptyView())
    }
}



//
//  ViewModel.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 24/3/23.
//

import Foundation

class CarsViewModel: ObservableObject {
    @Published var selectedcar: String = ""
    var onSave: () -> Void = { }
    var onClear: () -> Void = { }
    @Published var isSaved: Bool = false
}

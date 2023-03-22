//
//  TextFieldModifiers.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 21/3/23.
//

import SwiftUI

struct TextFieldModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.gray.opacity(0.2))
            .cornerRadius(5.0)
            .padding()
    }
}

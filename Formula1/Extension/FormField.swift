//
//  FormField.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 28/3/23.
//

import SwiftUI

struct FormField: View {
    
    @Binding var value: String
    var icon: String
    var placeHolder: String
    var isSecure = false
    
    var body: some View {
        Group {
            HStack {
                Image(systemName: icon).padding()
                Group {
                    if isSecure {
                        SecureField(placeHolder, text: $value)
                    } else {
                        TextField(placeHolder, text: $value)
                    }
                }.font(Font.system(size: 20, design: .monospaced))
                    .foregroundColor(.black)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 4)).padding()
        }
    }
}

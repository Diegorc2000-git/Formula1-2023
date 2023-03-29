//
//  HomeContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 21/3/23.
//

import SwiftUI

struct HomeContentView: View {
    var body: some View {
        
        VStack{
            Text("Hello, World!")
        }
        .accentColor(.black)
        .preferredColorScheme(.light)
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}

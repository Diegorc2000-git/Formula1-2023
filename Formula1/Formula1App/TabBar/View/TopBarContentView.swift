//
//  TopBarContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 14/3/23.
//

import SwiftUI

struct TopBarContentView: View {

    var body: some View {
        VStack {
            CustomTabView()
        }
    }
}

var tabs = ["house.fill", "map.fill", "car.side", "person.fill"]

struct CustomTabView: View {
    @State var selectedTab = "house.fill"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets

    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    TabView(selection: $selectedTab) {
                        HomeContentView()
                            .tag("house.fill")
                        
                        HomeContentView()
                            .tag("map.fill")
                        
                        HomeSecondTagView()
                            .tag("car.side")
                        
                        ProfileContentView()
                            .tag("person.fill")
                    }
                
                .ignoresSafeArea(.all, edges: .bottom)
                
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { image in
                        TabButton(image: image, selectedTab: $selectedTab)
                        
                        if image != tabs.last {
                            Spacer(minLength: 0)
                        }
                    }
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
                .background(.white)
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
                .padding(.horizontal)
                .padding(.bottom, edge!.bottom == 0 ? 20: 0)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        }
    }
}

struct TabButton: View {
    var image: String
    
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: { selectedTab = image }) {
            Image(systemName: "\(image)")
                .foregroundColor(selectedTab == image ? Color.gray: Color.black)
                .padding()
        }
    }
}

struct TopBarContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarContentView()
    }
}

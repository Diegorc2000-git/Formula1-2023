//
//  HomeSecondTagView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 27/3/23.
//

import SwiftUI

struct HomeSecondTagView: View {
    
    @StateObject var settings = CoordinatorSettings()
    
    let columns = [
        GridItem(.adaptive(minimum: 250) , spacing: 0)
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(LocalizedKeys.SecondTab.secondTabTitle)
                    .font(.title)
                    .padding(.leading, 24)
                    .padding(.top, 12)
                    .foregroundColor(.white)
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        NavigationLink(destination: ARHomeView().environmentObject(settings)) {
                            HStack(spacing: 24) {
                                Image(ImageAndIconConstants.arIcon)
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                Text(LocalizedKeys.SecondTab.menuArCellTitle)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .aspectRatio(1, contentMode: .fill)
                        
                        NavigationLink(destination: ARHomeView()) {
                            HStack(spacing: 24) {
                                Image(ImageAndIconConstants.flagIcon)
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                Text(LocalizedKeys.SecondTab.menuCicuitsCellTitle)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .aspectRatio(1, contentMode: .fill)
                        
                        NavigationLink(destination: ARHomeView()) {
                            HStack(spacing: 24) {
                                Image(ImageAndIconConstants.helmetIcon)
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                Text(LocalizedKeys.SecondTab.menuPilotsCellTitle)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .aspectRatio(1, contentMode: .fill)
                        
                        NavigationLink(destination: ARHomeView()) {
                            Text(LocalizedKeys.SecondTab.menuTeamsCellTitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .aspectRatio(1, contentMode: .fill)
                    }
                    .padding(.trailing, 12)
                    .padding(.leading, 12)
                }
            }
            .background(
                Image(ImageAndIconConstants.backgroundTag2)
                    .resizable()
                    .ignoresSafeArea()
            )
        }
        .accentColor(.black)
        .preferredColorScheme(.light)
    }
}

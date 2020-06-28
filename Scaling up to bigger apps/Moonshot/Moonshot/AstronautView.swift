//
//  AstronautView.swift
//  Moonshot
//
//  Created by Austin Carpenter on 6/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        .accessibility(label: Text(self.astronaut.name))
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    Text("Missions")
                        .font(.title)
                        .bold()
                        .padding(.top)
                        .padding(.horizontal)
                        .frame(width: geometry.size.width, alignment: .leading)
                    //Challenge 2
                    ForEach(self.viewModel.missionsForAstronaut(astronaut: self.astronaut), id: \.id) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle()
                                .stroke(Color.secondary, lineWidth: 1))
                                .accessibility(hidden: true)
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                                    .foregroundColor(.secondary)
                                    .accessibility(label: Text("Launch date: \(mission.formattedLaunchDate)"))
                            }
                            Spacer()
                        }.padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let viewModel = ViewModel()
    static var previews: some View {
        AstronautView(astronaut: viewModel.astronauts[0], viewModel: viewModel)
    }
}

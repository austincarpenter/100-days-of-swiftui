//
//  MissionView.swift
//  Moonshot
//
//  Created by Austin Carpenter on 6/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 15) {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.bottom)
                        .padding(.top)
                        .accessibility(label: Text("\(self.mission.displayName) badge"))
                    //Challenge 1
                    Text("Launch Date: " + self.mission.formattedLaunchDate)
                        .bold()
                        .padding(.horizontal)
                        .frame(width: geometry.size.width, alignment: .leading)
                    Text(self.mission.description)
                        .padding(.horizontal)
                    Text("Crew")
                        .font(.title)
                        .bold()
                        .padding(.top)
                        .padding(.horizontal)
                        .frame(width: geometry.size.width, alignment: .leading)
                    ForEach(self.viewModel.astronautsForMission(mission: self.mission), id: \.id) { astronaut in
                        NavigationLink(destination: AstronautView(astronaut: astronaut, viewModel: self.viewModel)) {
                            HStack {
                                Image(astronaut.id)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                    .overlay(Circle()
                                        .stroke(Color.secondary, lineWidth: 1))
                                VStack(alignment: .leading) {
                                    Text(astronaut.name)
                                        .font(.headline)
                                        .accessibility(label: Text("\(astronaut.name)."))
                                    self.viewModel.crewRoleForAstronaut(astronaut, andMission: self.mission).map {
                                        Text($0)
                                            .font($0 == "Commander" ? Font.body.bold() : Font.body)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                Spacer()
                            }.padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let viewModel = ViewModel()
    static var previews: some View {
        MissionView(mission: viewModel.missions[0], viewModel: viewModel)
    }
}

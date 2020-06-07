//
//  ContentView.swift
//  Moonshot
//
//  Created by Austin Carpenter on 6/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var viewModel = ViewModel()
    
    @State private var showsLaunchDates = true
    
    var body: some View {
        NavigationView {
            List(viewModel.missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, viewModel: self.viewModel)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.showsLaunchDates ? mission.formattedLaunchDate : self.crewNamesForMission(mission))
                            .font(self.showsLaunchDates ? .body : .callout)
                    }
                }
                
            }
            .navigationBarTitle("Moonshot")
            //Challenge 3
            .navigationBarItems(trailing: Button(action: {
                self.showsLaunchDates.toggle()
            }) {
                (showsLaunchDates ? Image(systemName: "person.2.fill") : Image(systemName: "calendar"))
                    .imageScale(.large)
            })
        }
    }
    
    func crewNamesForMission(_ mission: Mission) -> String {
        self.viewModel.astronautsForMission(mission: mission).map{$0.name}.joined(separator: ", ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

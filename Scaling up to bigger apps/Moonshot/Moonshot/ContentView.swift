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
                        .accessibility(hidden: true)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .accessibility(label: Text("\(mission.displayName)."))
                        Text(self.showsLaunchDates ? mission.formattedLaunchDate : self.crewNamesForMission(mission))
                            .font(self.showsLaunchDates ? .body : .callout)
                            .accessibility(label: (self.showsLaunchDates ? Text("Launch date: \(mission.formattedLaunchDate)") : Text("Crew members: \(self.crewNamesForMission(mission))")))
                    }.accessibility(addTraits: .isStaticText)
                }
                
            }
            .navigationBarTitle("Moonshot")
            //Challenge 3
            .navigationBarItems(
                trailing: Button(action: {
                    self.showsLaunchDates.toggle()
                }) {
                    (showsLaunchDates ? Image(systemName: "person.2.fill") : Image(systemName: "calendar"))
                        .imageScale(.large)
                        .accessibility(label: (showsLaunchDates ? Text("Show crew members") : Text("Show launch dates")))
                        .accessibility(addTraits: .isButton)
                        .accessibility(removeTraits: .isImage)
                }
            )
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

//
//  ViewModel.swift
//  Moonshot
//
//  Created by Austin Carpenter on 6/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import Foundation

struct ViewModel {
    var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    var missions: [Mission] = Bundle.main.decode("missions.json")
    
    func missionsForAstronaut(astronaut: Astronaut) -> [Mission] {
        
        var missions = [Mission]()
        
        for mission in self.missions {
            for crewMember in mission.crew {
                if crewMember.name == astronaut.id {
                    missions.append(mission)
                }
            }
        }
        
        return missions
    }
    
    func astronautsForMission(mission: Mission) -> [Astronaut] {
        
        var astronauts = [Astronaut]()
        
        for astronaut in self.astronauts {
            for crewMember in mission.crew {
                if crewMember.name == astronaut.id {
                    astronauts.append(astronaut)
                }
            }
        }
        
        return astronauts
    }
    
    func crewRoleForAstronaut(_ astronaut: Astronaut, andMission mission: Mission) -> String? {
        if let correctMission = missions.first(where: { $0.id == mission.id }) {
            
            for member in correctMission.crew {
                if member.name == astronaut.id {
                    return member.role
                }
            }
        }
        
        return nil
    }
}

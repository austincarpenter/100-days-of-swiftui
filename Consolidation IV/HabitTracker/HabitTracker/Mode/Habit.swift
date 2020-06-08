//
//  Habit.swift
//  HabitTracker
//
//  Created by Austin Carpenter on 8/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import Foundation

class Habit: Codable, Identifiable, ObservableObject {
    
    enum CodingKeys: CodingKey {
        case id, name, description, completedDates
    }
    
    let id = UUID()
    @Published var name: String
    @Published var description = ""
    @Published var completedDates = [Date]()
    
    init(name: String, description: String, completedDates: [Date] = []) {
        self.name = name
        self.description = description
        self.completedDates = completedDates
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        completedDates = try container.decode([Date].self, forKey: .completedDates)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(completedDates, forKey: .completedDates)
    }
}

extension Habit {
    static var example: Habit {
        Habit(name: "Weekly Run", description: "Complete a run of 5km+ once a week or more.")
    }
    
    static var examples: [Habit] {
        [Habit.example,
         Habit(name: "Practise Piano Exam", description: "Practise scales, arpeggios and pieces for July 2020 Grade 8 AMEB piano exam."),
         Habit(name: "Hour of Spanish", description: "Spend an hour learning Spanish from textbook.")]
    }
}

extension Habit {
    static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var formattedFinalDate: String {
        guard let finalDate = completedDates.first else {
            return "Never Completed"
        }
        return Habit.formatter.string(from: finalDate)
    }
}

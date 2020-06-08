//
//  ViewModel.swift
//  HabitTracker
//
//  Created by Austin Carpenter on 8/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var habits = [Habit]()
    
    init(habits: [Habit]? = nil) {
        if let habits = habits {
            self.habits = habits
        } else {
            loadHabits()
        }
    }
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
        saveHabits()
    }
    
    func appendDate(_ date: Date, to habit: Habit) {
        habit.completedDates.append(date)
        saveHabits()
    }
    
    func deleteHabits(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        saveHabits()
    }
    
    func loadHabits() {
        guard let data = UserDefaults.standard.data(forKey: "habits") else {
            print("No user data found.")
            return
        }

        let decoder = JSONDecoder()
        if let data = try? decoder.decode([Habit].self, from: data) {
            habits = data
        }
    }
    
    func saveHabits() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(habits) else {
            print("Unable to encode data.")
            return
        }
        
        UserDefaults.standard.set(data, forKey: "habits")
    }
}

extension ViewModel {
    static var example: ViewModel { ViewModel(habits: Habit.examples) }
}

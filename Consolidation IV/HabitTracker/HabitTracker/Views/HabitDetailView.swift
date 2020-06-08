//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Austin Carpenter on 8/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var habit: Habit

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(habit.description)
                Divider()
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 0) {
                    Text("Completed: ")
                        .font(.headline)
                    Text("\(habit.completedDates.count == 1 ? "\(habit.completedDates.count)" + " time" : "\(habit.completedDates.count)" + " times")")
                }
                HStack(spacing: 0) {
                    Text("Last Completion Date: ")
                        .font(.headline)
                    Text(habit.formattedFinalDate)
                }
            }
            Divider()
            RoundedButton(text: "Add completion", filled: true, maxHeight: 60) {
                self.viewModel.appendDate(Date(), to: self.habit)
            }
            Spacer()
        }
        .navigationBarTitle(habit.name)
        .padding(.horizontal, 20)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel.example
        let habit = viewModel.habits[0]
        return NavigationView {
            HabitDetailView(viewModel: viewModel, habit: habit)
                .navigationBarTitle(habit.name)
        }
    }
}

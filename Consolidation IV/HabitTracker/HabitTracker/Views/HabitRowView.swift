//
//  HabitRowView.swift
//  HabitTracker
//
//  Created by Austin Carpenter on 8/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct HabitRowView: View {
 
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var habit: Habit
    
    var body: some View {
        NavigationLink(destination: HabitDetailView(viewModel: viewModel, habit: habit)) {
            HStack(spacing: 15) {
                // Text("\(habit.completedDates.count)")
                //     .font(Font.system(.title, design: .rounded).monospacedDigit())
                //     .fontWeight(.semibold)
                //     .foregroundColor(.white)
                //     .padding(10)
                //     .background(Circle().fill(Color.accentColor))
                
                //Capped at 50
                Image(systemName: "\(habit.completedDates.count).circle.fill")
                    .imageScale(.large)
                    .font(Font.title.weight(.medium))
                    .foregroundColor(.accentColor)

                VStack(alignment: .leading) {
                    Text(habit.name)
                        .font(.headline)
                    Text(habit.description)
                }
                Spacer()
            }.padding(.vertical, 5)
        }
    }
}

struct HabitRowView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel.example
        let habit = viewModel.habits[0]
        return HabitRowView(viewModel: viewModel, habit: habit)
    }
}

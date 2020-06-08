//
//  ContentView.swift
//  HabitTracker
//
//  Created by Austin Carpenter on 8/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct HabitsView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var addSheetPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.habits) { habit in
                    HabitRowView(viewModel: self.viewModel, habit: habit)
                }
                .onDelete(perform: viewModel.deleteHabits(at:))
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                    self.addSheetPresented = true
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
        }
        .sheet(isPresented: $addSheetPresented) {
            HabitAddView(viewModel: self.viewModel)
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView(viewModel: .example)
    }
}

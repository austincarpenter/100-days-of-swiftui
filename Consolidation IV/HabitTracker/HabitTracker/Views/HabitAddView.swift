//
//  HabitAddView.swift
//  HabitTracker
//
//  Created by Austin Carpenter on 8/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct HabitAddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var viewModel: ViewModel
    
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .font(.headline)
                }
                Section {
                    TextField("Description", text: $description)
                }
            }
            .navigationBarTitle("Add Habit", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                        let habit = Habit(name: self.name, description: self.description)
                        self.viewModel.addHabit(habit)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                        .bold()
                    }
            )
        }
    }
}

struct HabitAddView_Previews: PreviewProvider {
    static var previews: some View {
        HabitAddView(viewModel: .example)
    }
}

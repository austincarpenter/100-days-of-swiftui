//
//  ContentView.swift
//  iExpense
//
//  Created by Austin Carpenter on 5/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct ExpensesModifer: ViewModifier {
    
    var amount: Int
    
    func colorForAmount(_ amount: Int) -> Color {
        switch amount {
            case ..<10:
                return .green
            case ..<100:
                return .yellow
            default:
                return .red
        }
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(colorForAmount(amount))
    }
}

struct ContentView: View {

    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                            .modifier(ExpensesModifer(amount: item.amount)) //Challenge 2
                    }
                }.onDelete(perform: removeItems(at:))
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading:
                    EditButton(), //Challenge 1
                trailing:
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
            )
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

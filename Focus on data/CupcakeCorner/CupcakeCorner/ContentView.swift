//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Austin Carpenter on 9/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //Challenge 3
    @ObservedObject var viewModel = ViewModel(order: Order())
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $viewModel.order.type) {
                        ForEach(0..<Order.types.count, id:\.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $viewModel.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(viewModel.order.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $viewModel.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if viewModel.order.specialRequestEnabled {
                        Toggle(isOn: $viewModel.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $viewModel.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: AddressView(viewModel: viewModel)) {
                        Text("Delivery Details")
                    }
                }
            }.navigationBarTitle("Cupcake Corner")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

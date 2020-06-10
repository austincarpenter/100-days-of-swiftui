//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Austin Carpenter on 9/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.order.name)
                TextField("Street Address", text: $viewModel.order.streetAddress)
                TextField("City", text: $viewModel.order.city)
                TextField("Zip", text: $viewModel.order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(viewModel: viewModel)) {
                    Text("Check out")
                }
            }.disabled(!viewModel.order.hasValidAddress)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(viewModel: ViewModel(order: Order()))
    }
}

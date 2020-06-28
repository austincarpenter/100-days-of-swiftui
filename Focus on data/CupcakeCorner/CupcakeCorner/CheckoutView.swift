//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Austin Carpenter on 9/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var showingSpinner = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        .accessibility(hidden: true)
                    Text("Your total is $\(self.viewModel.order.cost, specifier: "%.2f")")
                    Button("Place order") {
                        self.placeOrder()
                    }.padding()
                    ActivityIndicator(isAnimating: self.$showingSpinner, style: .large)
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(viewModel.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        request.timeoutInterval = 3
        
        showingSpinner = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.showingSpinner = false
            
            //Challenge 2
            guard let data = data else {
                print("No data in response")
                self.alertTitle = "An Error Occurred"
                
                if let error = error as? URLError {
                    if error.code == .notConnectedToInternet || error.code == .timedOut {
                        print("Error: Not connected to internet.")
                        self.alertMessage = "It appears you are not connected to the Internet or there is a problem with your connection."
                    } else {
                        print("Error: \(error.localizedDescription)")
                        self.alertMessage = "The error appears to be: '\(error.localizedDescription)'."
                    }
                } else {
                    print("Unknown error")
                    self.alertMessage = "An unknown error occurred. Please try again."
                }
                
                self.showingAlert = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.alertTitle = "Thank you!"
                self.alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            } else {
                print("Invalid response from server")
                self.alertMessage = "Something went wrong on our end after your order was sent off. Please try again."
            }
            
            self.showingAlert = true

        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(viewModel: ViewModel(order: Order()))
    }
}

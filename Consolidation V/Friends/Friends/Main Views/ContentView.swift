//
//  ContentView.swift
//  Friends
//
//  Created by Austin Carpenter on 13/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @ObservedObject var viewModel = ViewModel()
    
    var users: [User] { viewModel.users }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    UserRowView(viewModel: self.viewModel, user: user, showsDetailView: true, showsNextDetailView: true)
                }
            }
            .navigationBarTitle("Users")
        }
        .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK")))
        }.onAppear {
            self.viewModel.loadData { (errorTitle, errorMessage) in
                self.presentAlert(withTitle: errorTitle, message: errorMessage)
            }
        }
    }
    
    func presentAlert(withTitle title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
        DispatchQueue.main.async {
            self.showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView(viewModel: ViewModel.example)
    }
}

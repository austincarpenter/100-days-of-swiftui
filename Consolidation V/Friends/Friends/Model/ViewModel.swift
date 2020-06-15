//
//  ViewModel.swift
//  Friends
//
//  Created by Austin Carpenter on 14/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var users = [User]()
    
    init(users: [User] = []) {
        self.users = users
    }
    
    func loadData(errorHandler: ((String, String) -> ())?) {
        let jsonURL = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: jsonURL)
        request.timeoutInterval = 3

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                var message = "Unable to download data. "

                if let error = error as? URLError {
                    if error.code == .notConnectedToInternet || error.code == .timedOut {
                        message += "It appears you are not connected to the Internet or there is a problem with your connection."
                    } else {
                        message += "The error appears to be: '\(error.localizedDescription)'."
                    }
                } else {
                    message += "An unknown error occurred. Please try again."
                }
                
                return errorHandler!("Data Download Error", message)
                
            }
            
            guard let users = try? JSONDecoder().decode([User].self, from: data) else {
                return errorHandler!("Unknown Error", "Unable to interpret data.")
            }
            
            DispatchQueue.main.async {
                self.users = users
            }
        }.resume()
    }
    
    func friendsOfUser(_ user: User) -> [User] {
        var users = [User]()
        
        for friend in user.friends {
            if let userFriend = self.users.first(where: { $0.id == friend.id }) {
                users.append(userFriend)
            }
        }
        
        return users
    }
    
}

extension ViewModel {
    static let example = ViewModel(users: User.examples)
}

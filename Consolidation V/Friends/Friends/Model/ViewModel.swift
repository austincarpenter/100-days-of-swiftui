//
//  ViewModel.swift
//  Friends
//
//  Created by Austin Carpenter on 14/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI
import CoreData

class ViewModel: ObservableObject {
    
    var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func loadData(completionHandler: ((String?, String?) -> ())?) {
        
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
                
                return completionHandler!("Data Download Error", message)
                
            }
            
            guard let users = try? JSONDecoder().decode([UserJSON].self, from: data) as [UserJSON] else {
                return completionHandler!("Unknown Error", "Unable to interpret data.")
            }
    
            DispatchQueue.main.async {
                self.createCoreDataData(users: users)
            }
            
            completionHandler!(nil, nil)
            
            UserDefaults.standard.set(true, forKey: "hasDownloadedData")
        }.resume()
    }
    
    func createCoreDataData(users: [UserJSON]) {

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        for user in users {
            let coreDataUser = User(context: self.moc)
            coreDataUser.id = user.id
            coreDataUser.name = user.name
            coreDataUser.age = Int16(user.age)
            coreDataUser.isActive = user.isActive
            coreDataUser.company = user.company
            coreDataUser.email = user.email
            coreDataUser.about = user.about
            coreDataUser.registered = formatter.date(from: user.registered) ?? Date()
            try? self.moc.save()

            //Set tags
            for tag in user.tags {
                let coreDataTag = Tag(context: self.moc)
                coreDataTag.value = tag.lowercased()
                coreDataUser.tagsArray.append(coreDataTag)
                try? self.moc.save()
            }
            
        }
        
        //Get all users
        let coreDataUsers = try? self.moc.fetch(NSFetchRequest<User>(entityName: "User"))
    
        for user in users {
            for friend in user.friends {
                if let coreDataUser = coreDataUsers?.first(where: { $0.id == user.id }), let coreDataFriend = coreDataUsers?.first(where: { $0.id == friend.id }) {
                    coreDataUser.friendsArray.append(coreDataFriend)
                    try? self.moc.save()
                }
            }
        }
    }

}

// extension ViewModel {
//     // static let example = ViewModel(users: UserJSON.examples)
//     static let example = ViewModel(mo)
// }

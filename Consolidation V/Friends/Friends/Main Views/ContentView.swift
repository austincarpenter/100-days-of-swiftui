//
//  ContentView.swift
//  Friends
//
//  Created by Austin Carpenter on 15/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var selected = 0
    @State private var hasFinishedDownloading = false
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        
        if hasFinishedDownloading {
            return AnyView(TabView(selection: self.$selected) {
                UsersView()
                    .environment(\.managedObjectContext, self.moc)
                    .tabItem {
                        Image(systemName: (self.selected == 0 ? "person.2.fill" : "person.2"))
                            .imageScale(.large)
                        Text("Users")
                }.tag(0)
                TagsView()
                    .environment(\.managedObjectContext, self.moc)
                    .tabItem {
                        Image(systemName: (self.selected == 1 ? "tag.fill" : "tag"))
                            .imageScale(.large)
                        Text("Tags")
                }.tag(1)
            })
        } else {
            return AnyView(
                VStack(spacing: 15) {
                    ActivityIndicator(isAnimating: !$hasFinishedDownloading, style: .large, color: .gray)
                    Text("Downloading...")
                        .font(.title)
                        .bold()
                }.onAppear {
                    if !UserDefaults.standard.bool(forKey: "hasDownloadedData") { self.loadData() } else {
                        self.hasFinishedDownloading = true
                    }
                }
                .alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle),
                              message: Text(alertMessage),
                              dismissButton: .default(Text("Reload")) { self.loadData() } )
                }
            )
        }
    }
    
    func presentAlert(withTitle title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
        DispatchQueue.main.async {
            self.showingAlert = true
        }
    }

    func loadData() {
        
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
                
                self.presentAlert(withTitle: "Data Download Error", message: message)
                return
            }
            
            guard let users = try? JSONDecoder().decode([UserJSON].self, from: data) as [UserJSON] else {
                self.presentAlert(withTitle: "Unknown Error", message: "Unable to interpret data.")
                return
            }
    
            DispatchQueue.main.async {
                self.createCoreDataData(users: users)
                self.hasFinishedDownloading = true
            }
            
            UserDefaults.standard.set(true, forKey: "hasDownloadedData")
        }.resume()
    }
    
    func createCoreDataData(users: [UserJSON]) {

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        var coreDataUsers = [User]()
                
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

            coreDataUsers.append(coreDataUser)
            
            //Set tags
            for tag in user.tags {
                let coreDataTag = Tag(context: self.moc)
                coreDataTag.value = tag.lowercased()
                coreDataUser.tagsArray.append(coreDataTag)
                try? self.moc.save()
            }
        }
        
        for user in users {
            for friend in user.friends {
                if let coreDataUser = coreDataUsers.first(where: { $0.id == user.id }), let coreDataFriend = coreDataUsers.first(where: { $0.id == friend.id }) {
                    coreDataUser.friendsArray.append(coreDataFriend)
                    try? self.moc.save()
                }
            }
        }
    }
}

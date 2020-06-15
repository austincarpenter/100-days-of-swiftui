//
//  UsersView.swift
//  Friends
//
//  Created by Austin Carpenter on 13/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct UsersView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<User>(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)]) var fetchedUsers

    @State private var sortAscending = true
    @State private var sortButtonAngle = Angle(radians: 0)
    @State private var hideOffline = false
    
    var users: [User] {
        var users = Array(fetchedUsers)
        if !sortAscending { users.reverse() }
        if hideOffline { users.removeAll(where: { !$0.isActive }) }
        return users
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in
                    UserRowView(user: user, showsDetailView: true, showsNextDetailView: true)
                }
            }
            .navigationBarTitle("Users")
            .navigationBarItems(trailing:
                HStack {
                    Spacer()
                    Button(self.hideOffline ? "Show Offline" : "Hide Offline") {
                        self.hideOffline.toggle()
                    }
                    Button(action: {
                        self.sortAscending.toggle()
                        self.sortButtonAngle.radians = self.sortAscending ? 0 : .pi
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                            .imageScale(.large)
                            .rotationEffect(sortButtonAngle)
                            .animation(.easeInOut(duration: 0.25))
                            .padding(5)
                    }
                }
            )
        }
    }
}

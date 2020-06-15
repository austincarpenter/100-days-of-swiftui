//
//  UserDetailView.swift
//  Friends
//
//  Created by Austin Carpenter on 14/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    var user: User
    var showsDetailView: Bool
    var showsNextDetailView: Bool

    var body: some View {
        Form {
            Section(header:
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(user.isActive ? Color.green : Color.red)
                            .font(.caption)
                            .imageScale(.small)
                        Text(user.isActive ? "Online" : "Offline")
                        Spacer()
                    }
                    Group {
                        ParameterRowView(name: "Age", value: "\(user.age)")
                        ParameterRowView(name: "Company", value: user.wrappedCompany)
                        ParameterRowView(name: "User since", value: user.registeredDateString)
                        ParameterRowView(name: "Email", value: user.wrappedEmail)
                    }
                    Divider()
                    Text(user.wrappedDescription)
                        .font(.callout)
                        .lineLimit(4)
                    Divider()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(user.tagsArray, id: \.self) { tag in
                                Text(tag.wrappedValue)
                                    .font(.caption)
                                    .padding(7.5)
                                    .foregroundColor(.white)
                                    .background(Color.accentColor)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    Divider()
                    Text("Friends")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                }
                .padding(.top, 5)
                .foregroundColor(.primary)
                .font(.body)
            ) {
                ForEach(user.friendsArray.sorted(by: { $0.wrappedName < $1.wrappedName }), id:\.id) { user in
                    UserRowView(user: user, showsDetailView: self.showsNextDetailView, showsNextDetailView: false)
                        .buttonStyle(DefaultButtonStyle())
                }
            }
        }
        .navigationBarTitle("\(user.wrappedName)")
    }
}

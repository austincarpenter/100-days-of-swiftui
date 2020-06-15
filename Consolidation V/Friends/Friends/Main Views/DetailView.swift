//
//  DetailView.swift
//  Friends
//
//  Created by Austin Carpenter on 14/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var viewModel = ViewModel()
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
                        ParameterRowView(name: "Company", value: user.company)
                        ParameterRowView(name: "User since", value: user.registeredDateString)
                        ParameterRowView(name: "Email", value: user.email)
                    }
                    Divider()
                    Text(user.about)
                        .font(.callout)
                        .lineLimit(4)
                    Divider()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(user.tags, id: \.self){ tag in
                                Text(tag)
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
                //Friends list
                ForEach(viewModel.friendsOfUser(user)) { user in
                    UserRowView(viewModel: self.viewModel, user: user, showsDetailView: self.showsNextDetailView, showsNextDetailView: false)
                        .buttonStyle(DefaultButtonStyle())
                }
            }
        }
        .navigationBarTitle("\(user.name)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(viewModel: .example, user: .example, showsDetailView: true, showsNextDetailView: true)
        }
    }
}

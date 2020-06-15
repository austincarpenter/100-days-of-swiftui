//
//  UserRowView.swift
//  Friends
//
//  Created by Austin Carpenter on 14/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct UserRowView: View {
    
    var user: User
    var showsDetailView: Bool
    var showsNextDetailView: Bool
    
    var row: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .foregroundColor(user.isActive ? Color.green : Color.red)
                .imageScale(.small)
            VStack(alignment: .leading) {
                Text("\(user.wrappedName)")
                    .font(.headline)
                Text("\(user.age) yrs. old")
            }
            Spacer()
        }
        .padding(.horizontal, 5)
    }
    
    var body: some View {
        if showsDetailView {
            return AnyView(NavigationLink(destination: UserDetailView(user: user, showsDetailView: showsDetailView, showsNextDetailView: showsNextDetailView)) {
                row
            })
        } else {
            return AnyView(row)
        }
    }
}

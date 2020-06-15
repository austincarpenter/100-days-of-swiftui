//
//  TagsView.swift
//  Friends
//
//  Created by Austin Carpenter on 15/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct TagsView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<Tag>(entity: Tag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tag.value, ascending: true)]) var tags

    var body: some View {
        NavigationView {
            List(tags, id:\.value) { tag in
                Text(tag.wrappedValue)
                    .font(.headline)
                Spacer()
                Text("\(tag.usersArray.count) \(tag.usersArray.count == 1 ? "user" : "users")")
            }.navigationBarTitle("Tags")
        }
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
    }
}

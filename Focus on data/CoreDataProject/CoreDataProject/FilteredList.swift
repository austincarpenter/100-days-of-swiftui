//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Austin Carpenter on 13/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>:View {
    
    var fetchRequest: FetchRequest<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { entity in
            self.content(entity)
            
        }
    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}

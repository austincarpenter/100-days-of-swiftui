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
    
    //Challenge 1 + 2
    init(filterKey: String, filter: String, filterValue: String, sortDescriptors: [NSSortDescriptor] = [], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(filter) %@", filterKey, filterValue))
        self.content = content
    }
    
    //Challenge 3
    init(filterKey: String, filter: CoreDataFilter, filterValue: String, sortDescriptors: [NSSortDescriptor] = [], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(filter) %@", filterKey, filterValue))
        self.content = content
    }

}

enum CoreDataFilter: String {
    case beginsWith = "BEGINSWITH"
    case endsWith = "ENDSWITH"
    case contains = "CONTAINS"
    case equals = "=="
    case isLessThan = "<"
    case isGreaterThan = ">"
}

//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Austin Carpenter on 18/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}

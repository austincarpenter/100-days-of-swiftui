//
//  Wrap.swift
//  MultiplicationGame
//
//  Created by Austin Carpenter on 4/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct Wrap<Wrapped: UIView>: UIViewRepresentable {
    typealias Updater = (Wrapped, Context) -> Void

    var makeView: () -> Wrapped
    var update: (Wrapped, Context) -> Void

    init(_ makeView: @escaping @autoclosure () -> Wrapped,
         updater update: @escaping Updater) {
        self.makeView = makeView
        self.update = update
    }

    func makeUIView(context: Context) -> Wrapped {
        makeView()
    }

    func updateUIView(_ view: Wrapped, context: Context) {
        update(view, context)
    }
}

extension Wrap {
    init(_ makeView: @escaping @autoclosure () -> Wrapped,
         updater update: @escaping (Wrapped) -> Void) {
        self.makeView = makeView
        self.update = { view, _ in update(view) }
    }

    init(_ makeView: @escaping @autoclosure () -> Wrapped) {
        self.makeView = makeView
        self.update = { _, _ in }
    }
}

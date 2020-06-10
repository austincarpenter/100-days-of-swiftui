//
//  Extras.swift
//  CupcakeCorner
//
//  Created by Austin Carpenter on 10/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

///A view representing a `UIActivityIndicatorView`, used to present a share sheet to the user.
struct ActivityIndicator: UIViewRepresentable {

    ///A variable indicating whether the indicator is animating.
    @Binding var isAnimating: Bool
    
    ///The style of the spinner.
    let style: UIActivityIndicatorView.Style?
    
    ///The colour of the spinner.
    let color: UIColor = .gray

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: style ?? .medium)
        indicatorView.color = color
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

//@Published conformance to Codable
//from https://blog.hobbyistsoftware.com/2020/01/adding-codeable-to-published/
extension Published:Decodable where Value:Decodable {
    public init(from decoder: Decoder) throws {
        let decoded = try Value(from:decoder)
        self = Published(initialValue:decoded)
    }
}

extension Published:Encodable where Value:Decodable {

    public func encode(to encoder: Encoder) throws {

        let mirror = Mirror(reflecting: self)
        if let valueChild = mirror.children.first(where: { $0.label == "value"
        }) {
            if let value = valueChild.value as? Encodable {
                do {
                    try value.encode(to: encoder)
                    return
                } catch let error {
                    assertionFailure("Failed encoding: \(self) - \(error)")
                }
            }
            else {
                assertionFailure("Decodable Value not decodable. Odd \(self)")
            }
        }
        else {
            assertionFailure("Mirror Mirror on the wall - why no value y'all : \(self)")
        }
    }
}

extension String {
    //Challenge 1
    var isEmptyOrContainsWhitespace: Bool {
        isEmpty || self.trimmingCharacters(in: .whitespacesAndNewlines).count == 0
    }
}

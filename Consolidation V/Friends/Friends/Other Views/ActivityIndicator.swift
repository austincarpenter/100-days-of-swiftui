//
//  ActivityIndicator.swift
//  FavouriteThings
//
//  Created by Austin Carpenter on 30/4/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI
import UIKit

///A view representing a `UIActivityIndicatorView`, used to present a share sheet to the user.
struct ActivityIndicator: UIViewRepresentable {

    ///A variable indicating whether the indicator is animating.
    @Binding var isAnimating: Bool
    
    ///The style of the spinner.
    let style: UIActivityIndicatorView.Style
    
    ///The colour of the spinner.
    let color: UIColor

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: style)
        indicatorView.color = color
        return indicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

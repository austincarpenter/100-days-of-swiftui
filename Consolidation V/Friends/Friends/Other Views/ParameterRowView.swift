//
//  ParameterRowView.swift
//  Friends
//
//  Created by Austin Carpenter on 15/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct ParameterRowView: View {
    
    var name, value: String
    
    var body: some View {
        VStack {
            Divider()
                .padding(.bottom, 5)
            HStack {
                Text(name)
                    .font(.headline)
                Spacer()
                Text(value)
            }
        }
    }
}

struct ParameterRowView_Previews: PreviewProvider {
    static var previews: some View {
        ParameterRowView(name: "Name", value: "Austin Carpenter")
    }
}

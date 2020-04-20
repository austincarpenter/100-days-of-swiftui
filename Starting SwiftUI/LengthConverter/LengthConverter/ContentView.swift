//
//  ContentView.swift
//  LengthConverter
//
//  Created by Austin Carpenter on 18/4/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var userInput = ""
    @State private var originalUnit = 0
    @State private var destinationUnit = 0

    let units = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]

    @Environment(\.locale) var locale
    
    var mesasurementFormatter: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
        formatter.locale = self.locale
        return formatter
    }
    
    var output: String {
        var value = Measurement(value: Double(userInput) ?? 0, unit: units[originalUnit])
        value.convert(to: units[destinationUnit])
        return mesasurementFormatter.string(from: value)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter a value")) {
                    TextField("Amount", text: $userInput)
                }
                Section(header: Text("Convert from")) {
                    Picker("Original unit", selection: $originalUnit) {
                        ForEach(0..<units.count) {
                            Text("\(self.mesasurementFormatter.string(from: self.units[$0]))")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Convert to")) {
                    Picker("Destination unit", selection: $destinationUnit) {
                        ForEach(0..<units.count) {
                            Text("\(self.mesasurementFormatter.string(from: self.units[$0]))")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text(output)
                }
            }.navigationBarTitle("Length Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "en"))
    }
}

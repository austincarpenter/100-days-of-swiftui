//
//  ContentView.swift
//  BucketList
//
//  Created by Austin Carpenter on 17/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {

    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    @State private var isUnlocked = false

    
    var alert: Alert? {
        if showingPlaceDetails {
            return Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                self.showingEditScreen = true
            })
        } else if showingErrorAlert {
            return Alert(title: Text("Unable to unlock device"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        return nil
    }
    
    
    var body: some View {
        
        let alertBinding = Binding(
            get: {
                self.showingPlaceDetails || self.showingErrorAlert
            }, set: {
                self.showingPlaceDetails = $0
                self.showingErrorAlert = $0
            }
        )
        
        return ZStack {
            if isUnlocked {
                MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                    .edgesIgnoringSafeArea(.all)
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.title = "Example Location"
                            newLocation.coordinate = self.centerCoordinate
                            self.locations.append(newLocation)
                            
                            self.selectedPlace = newLocation
                            self.showingEditScreen = true
                        }) {
                            Image(systemName: "plus")
                                //Challenge 1, increases tappable region
                                .padding()
                                .background(Color.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
                }
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: alertBinding) {
            //Challenge 3
            //Testing custom binding.
            alert!
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: fileName)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.showingErrorAlert = true
                        self.errorMessage = "Authentication failed. Please try again."
                    }
                }
            }
        } else {
            self.showingErrorAlert = true
            self.errorMessage = "Please use a device with either Touch ID or Face ID."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

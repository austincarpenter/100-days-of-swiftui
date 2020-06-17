//
//  ContentView.swift
//  Instafilter
//
//  Created by Austin Carpenter on 16/6/20.
//  Copyright © 2020 Austin Carpenter. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var processedImage: UIImage?
    @State private var inputImage: UIImage?

    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var showingAlert = false

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    @State private var filterScale = 5.0

    let context = CIContext()
    let operationQueue = OperationQueue()

    init() {
        operationQueue.maxConcurrentOperationCount = 1
    }
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )

        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)

                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }

                //Challenge 3
                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity)
                            .disabled(!hasIntensity)
                    }

                    HStack {
                        Text("Radius")
                        Slider(value: radius, in: 0...200)
                            .disabled(!hasRadius)
                    }

                    HStack {
                        Text("Scale")
                        Slider(value: scale, in: 0...10)
                            .disabled(!hasScale)
                    }
                }.padding(.vertical)

                HStack {
                    Button("Change Filter") {
                        self.showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.showingAlert = true
                            return
                        }

                        let imageSaver = ImageSaver()

                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }

                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            //Challenge 1
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Unable to save"), message: Text("Please first select an image to save."), dismissButton: .default(Text("OK")))
            }
            .actionSheet(isPresented: self.$showingFilterSheet) {
                //Challenge 2
                ActionSheet(title: Text("Select a filter (Current Filter: \"\(CIFilter.localizedName(forFilterName: self.currentFilter.name) ?? "Unknown Filter")\")"), buttons: [
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage: CIImage
        
        if let ciImage = inputImage.ciImage {
            beginImage = ciImage
        }
            
        else {
            beginImage = CIImage(cgImage: inputImage.cgImage!).oriented(CGImagePropertyOrientation(inputImage.imageOrientation))
        }

        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    var hasIntensity: Bool {
        currentFilter.inputKeys.contains(kCIInputIntensityKey)
    }

    var hasRadius: Bool {
        currentFilter.inputKeys.contains(kCIInputRadiusKey)
    }

    var hasScale: Bool {
        currentFilter.inputKeys.contains(kCIInputScaleKey)
    }

    func applyProcessing() {
        if hasIntensity {
            print("set intensity \(filterIntensity)")
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if hasRadius {
            print("set radius \(filterRadius)")
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        if hasScale {
            print("set scale \(filterScale)")
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }

        operationQueue.cancelAllOperations()
        let operation = BlockOperation()
        operation.addExecutionBlock {
            if let cgimg = self.context.createCGImage(outputImage, from: outputImage.extent) {
                let uiImage = UIImage(cgImage: cgimg)
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                    self.processedImage = uiImage
                }
            }
        }
        operationQueue.addOperation(operation)
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
            @unknown default:
                fatalError("Unknown uiOrientation \(uiOrientation)")
        }
    }
}

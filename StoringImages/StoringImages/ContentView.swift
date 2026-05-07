//
//  ContentView.swift
//  HelloCoreML
//
//  Created by Mohammad Azam on 5/19/23.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PhotoSelection: Hashable {

    var photoItem: PhotosPickerItem?
    var image: UIImage?
}

struct ContentView: View {
    
    @State private var isCameraSelected: Bool = false
    @Environment(\.modelContext) private var context
    @State private var selection: PhotoSelection = PhotoSelection()
    
    @Query private var furnitures: [Furniture] = []
    
    let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
    ]
    
    private func saveFurniture(with imageData: Data) {
        
        guard let uiImage = UIImage(data: imageData) else {
            print("Failed to create UIImage from data.")
            return
        }
        
        let resizedImage = uiImage.resizeTo(to: CGSize(width: 200, height: 200))
        guard let resizedImageData = resizedImage.pngData() else {
            print("Failed to convert UIImage to data.")
            return
        }
        
        let furniture = Furniture(photo: resizedImageData)
        context.insert(furniture)
    }
    
    private func handleSelectedPhotoItem() {
        
        if let selectedPhotoItem = selection.photoItem {
            selectedPhotoItem.loadTransferable(type: Data.self) { result in
                switch result {
                    case .success(let data):
                        if let imageData = data {
                            saveFurniture(with: imageData)
                            selection = PhotoSelection()
                        }
                    case .failure(let error):
                        print("Error loading photo item: \(error.localizedDescription)")
                }
            }
        } else if let img = selection.image, let imageData = img.pngData() {
                saveFurniture(with: imageData)
                selection = PhotoSelection()
        }
    }
    
    var body: some View {
        
        VStack {
            
            LazyVGrid(columns: columns, content: {
                
                ForEach(furnitures) { furniture in
                    if let furniturePhoto = furniture.photo, let img = UIImage(data: furniturePhoto) {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                
            })
            
            Spacer()
            HStack {
                
                PhotosPicker(selection: $selection.photoItem, matching: .images, photoLibrary: .shared()) {
                   Text("Select a Photo")
                }
                  
                Button("Camera") {
                    isCameraSelected = true
                }.buttonStyle(.bordered)
            }
            
        }
        .onChange(of: selection, {
            handleSelectedPhotoItem()
        })
        
        .sheet(isPresented: $isCameraSelected, content: {
            ImagePicker(image: $selection.image, sourceType: .camera)
        })
        .padding()
        .navigationTitle("SwiftData Storing Images")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }.modelContainer(for: Furniture.self, inMemory: true)
}

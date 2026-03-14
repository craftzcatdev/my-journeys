//
//  EditPetView.swift
//  Paws
//
//  Created by Hai Ng. on 14/3/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPetView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var pet: Pet
    @State private var photoPickerItem: PhotosPickerItem?
    
    var body: some View {
        Form{
            //MARK: - IMAGE
            if let imageData = pet.photo {
                if let imaage = UIImage(data: imageData) {
                    Image(uiImage: imaage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8, style: .circular)
                        )
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: 300
                        )
                        .padding(.top)
                }
            } else {
                CustomContentUnaviableView(
                    icon: "pawprint.circle",
                    title: "No photo",
                    description: "Add a photo of your favorite pet to make easier to find them."
                )
                .padding(.top)
            }
            //MARK: - PHOTO PICKER
            PhotosPicker(selection: $photoPickerItem, matching: .images) {
                Label("Select a photo", systemImage: "photo.badge.plus")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .listRowSeparator(.hidden)
            
            //MARK: - TEXT FIELD
            TextField("Name", text: $pet.name)
                .textFieldStyle(.roundedBorder)
                .font(.largeTitle.weight(.light))
                .padding(.vertical)
            
            //MARK: - BUTTON
            Button {
                dismiss()
            } label: {
                Text("Save")
                    .font(.title3.weight(.medium))
                    .padding(8)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .listRowSeparator(.hidden)
            .padding(.bottom)
            

            
        } //: FORM
        .listStyle(.plain)
        .navigationTitle("Edit \(pet.name)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onChange(of: photoPickerItem) {
            Task {
                pet.photo = try? await photoPickerItem?
                    .loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    NavigationStack {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try! ModelContainer(
                for: Pet.self,
                configurations: configuration
            )
            let simpleData = Pet(name: "Daisy")
            
            return EditPetView(pet: simpleData)
                .modelContainer(container)
        } catch {
            fatalError("Failed to load view. \(error.localizedDescription)")
        }
    }
}

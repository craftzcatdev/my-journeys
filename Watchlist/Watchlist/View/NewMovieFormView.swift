//
//  NewMovieFormView.swift
//  Watchlist
//
//  Created by Hai Ng. on 14/3/26.
//

import SwiftUI
import SwiftData

struct NewMovieFormView: View {
    //MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var selectedGrenre: Genre = .kids
    
    //MARK: - FUNCTIONS
    private func addNewMovie() {
        let newMovie = Movie(title: title, genre: selectedGrenre)
        modelContext.insert(newMovie)
        title=""
        selectedGrenre = .kids
    }
    
    var body: some View {
        Form {
            List {
                //MARK: - HEADER
                Text("What to Watch?")
                    .font(.largeTitle.weight(.black))
                    .foregroundStyle(.blue.gradient)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                
                //MARK: - TITLE
                TextField("Movie Title", text: $title)
                    .textFieldStyle(.automatic)
                    .font(.largeTitle.weight(.light))
                
                //MARK: - GRENRE
                Picker("Genre", selection: $selectedGrenre){
                    ForEach(Genre.allCases) { genre in
                        Text(genre.name)
                            .tag(genre)
                    }
                }
                
                //MARK: - SAVE BUTTON
                Button {
                    if title.isEmpty || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        print("Input is invalid")
                        return
                    } else {
                        print("Valid Input \(title) - \(selectedGrenre)")
                        addNewMovie()
                        dismiss()
                    }
                } label: {
                    Text("Save")
                        .font(.title2.weight(.medium))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.extraLarge)
                .buttonBorderShape(.roundedRectangle(radius: .infinity))
                .disabled(title.isEmpty || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                //MARK: - CANCEL BUTTON
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                        .font(.title3.weight(.medium))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                }

                
            } //LIST
            .listRowSeparator(.hidden)
        }//FORM
    }
}

#Preview {
    NewMovieFormView()
}

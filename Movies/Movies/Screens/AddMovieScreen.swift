//
//  AddMovieView.swift
//  Movies
//
//  Created by Hai Ng. on 15/3/26.
//

import SwiftUI
import SwiftData

struct AddMovieScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var year: Int?
    @State private var selectedActor: Set<Actor> = []
    @State private var genre: Genre = .action
    
    private var isFormvalid: Bool {
        !title.isEmptyOrWhitespace && year != nil && !selectedActor.isEmpty
    }
    
    var body: some View {
        Form {
            Picker("Select Genre", selection: $genre){
                ForEach(Genre.allCases){ genre in
                    Text(genre.title).tag(genre)
                }
            }
            .pickerStyle(.palette)
            
            TextField("Title", text: $title)
            TextField("Year", value: $year ,format: .number)
            
            Section("Select actors") {
                ActorSelectionView(selectedActors: $selectedActor)
                
            }
        }
        .onChange(of: selectedActor, {
            print(selectedActor.count)
        })
        .navigationTitle("Add Movie")
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close"){
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save"){
                    guard let year = year else { return }
                    
                    let movie = Movie(title: title, year: year, genre: genre)
                    movie.actors = Array(selectedActor)
                    
                    selectedActor.forEach { actor in
                        actor.movies.append(movie)
                        context.insert(actor)
                    }
                    
                    context.insert(movie)
                    
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
                }
                .disabled(!isFormvalid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMovieScreen()
            .modelContainer(for: [Movie.self])
    }
}

//
//  MovieListScreen.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @State private var isAddMoviePresented: Bool = false
    @State private var isAddActorPresented: Bool = false
    @State private var actorName: String = ""
    
    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Movies")
                .font(.largeTitle.weight(.semibold))
            MovieListView(movies: movies)
            
            Text("Actors")
                .font(.largeTitle.weight(.semibold))
            ActorListView(actors: actors)
        }
//        .navigationTitle("Movies")
        .toolbar {
                
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    isAddActorPresented.toggle()
                } label: {
                    Label("Actor", systemImage: "person.badge.plus")
                        .labelStyle(.iconOnly)
                }

            }
                
                
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAddMoviePresented.toggle()
                } label: {
                    Label("Add", systemImage: "plus")
                        .labelStyle(.iconOnly)
                }

            }
        }
        .sheet(isPresented: $isAddMoviePresented) {
            NavigationStack {
                AddMovieScreen()
            }
        }
        .sheet(isPresented: $isAddActorPresented) {
            VStack(alignment: .leading) {
                Text("Add Actor")
                    .font(.largeTitle.weight(.bold))
                    
                TextField("Actor Name", text: $actorName)
                    .textFieldStyle(.plain)
                    .padding(12)
                    .background(.tertiary)
                    .clipShape(.capsule)
                    .font(.title.weight(.light))
                    
                Button {
                    isAddActorPresented = false
                    saveActor()
                } label: {
                    Text("Save")
                        .font(.title.weight(.regular))
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding(.top, 12)
                .buttonStyle(.glassProminent)
                    

            }
            .padding(.horizontal, 20)
            .presentationDetents([.fraction(0.30)])
        }
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self, Review.self, Actor.self])
    }
}

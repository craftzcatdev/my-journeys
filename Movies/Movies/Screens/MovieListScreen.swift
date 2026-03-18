//
//  MovieListScreen.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import SwiftUI
import SwiftData

enum Sheets: Identifiable {
    var id: Int {
        hashValue
    }
    
    case addMovie
    case addActor
    case showFilter
}

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var context
    
    // FIX: `#Predicate` là một macro của `SwiftData`, yêu cầu Swift biết chính xác kiểu của đối tượng đang được filter.
    @Query(filter: #Predicate<Movie> { $0.title.contains("Batman") } ) private var movies: [Movie]
    
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @State private var actorName: String = ""
    
    @State private var activeSheet: Sheets?
    @State private var filterOption: FilterOption = .none
    
    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("Movies")
                    .font(.largeTitle.weight(.semibold))
                Spacer()
                
                Button {
                    activeSheet = .showFilter
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.title.weight(.light))
                        .tint(.primary)
                }

            }
            .padding()
            MovieListView(filterOption: filterOption)
            
            Text("Actors")
                .font(.largeTitle.weight(.semibold))
                .padding()
            ActorListView(actors: actors)
        }
        //        .navigationTitle("Movies")
        .toolbar {
                
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    activeSheet = .addActor
                } label: {
                    Label("Actor", systemImage: "person.badge.plus")
                        .labelStyle(.iconOnly)
                }

            }
                
                
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    activeSheet = .addMovie
                } label: {
                    Label("Add", systemImage: "plus")
                        .labelStyle(.iconOnly)
                }

            }
        }
        .sheet(item: $activeSheet, content: { activeSheet in
            switch activeSheet {
            case .addMovie:
                NavigationStack {
                    AddMovieScreen()
                }
            case .addActor:
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
                        saveActor()
                        self.activeSheet = nil
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
            case .showFilter:
                FilterSelectionView(filterOption: $filterOption)
            }
        })
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self, Review.self, Actor.self])
    }
}

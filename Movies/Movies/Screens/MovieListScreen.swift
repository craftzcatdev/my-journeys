//
//  MovieListScreen.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {
    
    @Query(sort: \Movie.title, order: .reverse) private var movies: [Movie]
    @State private var isAddMoviePresented: Bool = false
    
    var body: some View {
        MovieListView(movies: movies)
            .navigationTitle("Movies")
            .toolbar {
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
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self])
    }
}

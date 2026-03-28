//
//  SearchView.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

// SearchView.swift
import SwiftUI

struct SearchView: View {
    @State private var query = ""
    
    var filteredMovies: [Movie] {
        query.isEmpty ? Movie.samples : Movie.samples.filter {
            $0.title.localizedCaseInsensitiveContains(query)
        }
    }
    
    var body: some View {
        List(filteredMovies) { movie in
            NavigationButton(push: .movieDetail(movie: movie)) {
                HStack {
                    Image(systemName: "film.fill")
                        .foregroundStyle(.blue)
                    Text(movie.title)
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("\(movie.rating, specifier: "%.1f")")
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
        }
        .searchable(text: $query, prompt: "Search movies...")
        .navigationTitle("Search")
    }
}

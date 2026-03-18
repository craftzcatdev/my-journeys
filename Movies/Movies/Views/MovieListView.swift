//
//  MovieListView.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    
    @Query private var movies: [Movie]
    let filterOption: FilterOption
    
    init (filterOption: FilterOption = .none) {
        self.filterOption = filterOption
        
        switch self.filterOption {
        case .title(let movieTitle):
            _movies = Query(
                filter: #Predicate<Movie> { $0.title.contains(movieTitle)
                },
                animation: .bouncy)
        case .reviewCount(let numberOfReview):
            _movies = Query(filter: #Predicate<Movie> {$0.reviews.count >= numberOfReview}, animation: .bouncy)
            
        case .actorCount(let numberOfActor):
            _movies = Query(filter: #Predicate<Movie> {$0.actors.count >= numberOfActor}, animation: .bouncy)
        case .none:
            _movies = Query()
        }
    }
    
    @Environment(\.modelContext) private var context
    
    private func deleteMovie(indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = movies[index]
            context.delete(movie)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                
                NavigationLink(value: movie) {
                    HStack(alignment: .firstTextBaseline){
                        VStack(alignment: .leading) {
                            Text(movie.title)
                            Text("Number of reviews: \(movie.reviewCount)")
                                .font(.caption)
                            Text("Number of actors: \(movie.actorCount)")
                                .font(.caption)
                        }
                        Spacer()
                        Text(movie.year.description)
                    }
                }
            }
            .onDelete(perform: deleteMovie)
        }
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailsScreen(movie: movie)
        }
    }
}

#Preview {
    MovieListView(filterOption: .none)
        .modelContainer(for: [Movie.self])
}

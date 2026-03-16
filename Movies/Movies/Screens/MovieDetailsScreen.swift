//
//  MovieDetailsScreen.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import SwiftUI
import SwiftData

struct MovieDetailsScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    let movie: Movie
    
    @State private var title: String = ""
    @State private var year: Int?
    @State private var isShowReviewScreen: Bool = false
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format:.number)
            
            Button("Update") {
                guard let year = year else { return }
                
                movie.title = title
                movie.year = year
                
                do {
                    try context.save()
                    dismiss()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .buttonStyle(.glassProminent)
            .frame(minWidth: 0, maxWidth: .infinity)
            
            Section(header: Text("Movie Details")) {
                Button {
                    isShowReviewScreen = true
                } label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                if let reviews = movie.reviews {
                    if reviews.isEmpty {
                        ContentUnavailableView {
                            VStack {
                                Image(systemName: "wind.snow.circle.fill")
                                    .font(.system(size: 60).weight(.black))
                                    .foregroundStyle(.gray)
                                Spacer()
                                Text("No Review")
                                    .font(.title.weight(.semibold))
                            }
                        }
                    } else {
                        ReviewListView(reviews: reviews)
                    }
                }

            }

        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            title = movie.title
            year = movie.year
        }
        .sheet(isPresented: $isShowReviewScreen) {
            NavigationStack {
                AddReviewScreen(movie: movie)
            }
        }
    }
}

struct MovieDetailContainerScreen: View {
    
    @Environment(\.modelContext) private var context
    @State private var movie: Movie?
    
    var body: some View {
        ZStack {
            if let movie {
                MovieDetailsScreen(movie: movie)
            }
        }
        .onAppear {
            movie = Movie(title: "Spider-Man: No Way Home", year: 2022)
            context.insert(movie!)
        }
    }
}

#Preview {
    MovieDetailContainerScreen()
        .modelContainer(for: [Movie.self])
}

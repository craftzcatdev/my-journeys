//
//  MovieDetailView.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    @Environment(\.router) private var router
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Header
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.15))
                    .frame(height: 200)
                    .overlay(
                        Image(systemName: "film.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)
                    )
                
                Group {
                    Text(movie.title)
                        .font(.title.bold())
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                        Text("Rating: \(movie.rating, specifier: "%.1f") / 10")
                    }
                    .font(.headline)
                    .foregroundStyle(.orange)
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                
                // Full Screen Play button
                Button {
                    router.presentFullScreen(.moviePlayer(movieID: movie.id))
                } label: {
                    Label("Watch Now", systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                
                // Navigate đến Actor — push tiếp từ detail
                VStack(alignment: .leading, spacing: 10) {
                    Text("Cast").font(.title2.bold()).padding(.horizontal)
                    
                    ForEach(sampleActors, id: \.0) { actorID, actorName in
                        NavigationButton(push: .actorDetail(actorID: actorID, actorName: actorName)) {
                            HStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .foregroundStyle(.gray)
                                    )
                                Text(actorName)
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                // Add to Favorite — sheet
                NavigationButton(sheet: .addToFavorite(movie: movie)) {
                    Label("Add to Favorites", systemImage: "heart")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink.opacity(0.1))
                        .foregroundColor(.pink)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    let sampleActors = [
        ("nm0000288", "Christian Bale"),
        ("nm0634240", "Heath Ledger"),
        ("nm0000323", "Gary Oldman"),
    ]
}

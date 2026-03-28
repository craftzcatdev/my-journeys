//
//  FavoriteView.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import SwiftUI

// FavoriteView.swift
struct FavoriteView: View {
    var body: some View {
        // Cùng navigate đến movieDetail như HomeView — KHÔNG duplicate code
        NavigationButton(push: .movieDetail(movie: Movie.samples[0])) {
            Label("Open Top Favorite", systemImage: "heart.fill")
                .padding()
                .background(Color.pink.opacity(0.1))
                .cornerRadius(10)
        }
        .navigationTitle("Favorites")
    }
}

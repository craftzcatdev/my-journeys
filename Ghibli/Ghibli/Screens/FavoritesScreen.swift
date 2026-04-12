//
//  FavoritesScreen.swift
//  Ghibli
//
//  Created by Hai Ng. on 12/4/26.
//

import SwiftUI

struct FavoritesScreen: View {
    
    let filmsViewModel: FilmsViewModel
    var films: [Film] {
        /// TODO: get favorites
        /// retrieve ids from storage
        /// get data for favorite ids from films data
        return []
    }

    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView(
                        "No Favorites yet",
                        systemImage: "heart"
                    )
                } else {
                    
                    FilmListView(
                        films: films,
                    )
                }
            }
            .navigationTitle(Text("Favorites"))
        }
    }
}

#Preview {
    FavoritesScreen(
        filmsViewModel: FilmsViewModel(service: MockGhiBliService())
    )
}

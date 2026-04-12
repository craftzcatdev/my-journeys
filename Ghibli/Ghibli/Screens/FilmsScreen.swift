//
//  FilmsScreen.swift
//  Ghibli
//
//  Created by Hai Ng. on 12/4/26.
//

import SwiftUI

struct FilmsScreen: View {
    
    let filmsViewModel: FilmsViewModel

    var body: some View {
        NavigationStack {
            FilmListView(filmViewModels: filmsViewModel)
                .navigationTitle("Ghibli Movies")
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    FilmsScreen(filmsViewModel: FilmsViewModel(service: MockGhiBliService()))
}

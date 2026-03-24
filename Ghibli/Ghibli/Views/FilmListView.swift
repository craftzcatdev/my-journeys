//
//  FilmListView.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import SwiftUI

struct FilmListView: View {
    
    @State private var filmViewModels = FilmsViewModel()
    
    var body: some View {
        List(filmViewModels.films) {
            Text($0.title)
        }
        .task {
            await filmViewModels.fetchFilms()
        }
    }
}

#Preview {
    FilmListView()
}

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
            Group {
                switch filmsViewModel.state {
                    case .idle:
                        Text("No Films Yet.")

                    case .loading:
                        ProgressView {
                            Text("Loading...")
                        }
                    case .loaded(let films):
                        FilmListView(films: films)
                            
                    case .error(let string):
                        Text("Error: \(string)")
                            .foregroundStyle(.pink)
                }
                    
            }
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

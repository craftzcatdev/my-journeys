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
        NavigationStack {
            switch filmViewModels.state {
                case .idle:
                    Text("No Films Yet.")

                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    List(films) {
                        Text($0.title)
                    }
                case .error(let string):
                    Text("Error: \(string)")
                        .foregroundStyle(.pink)
            }

        }
        .task {
            await filmViewModels.fetch()
        }
    }
}

#Preview {
    FilmListView()
}

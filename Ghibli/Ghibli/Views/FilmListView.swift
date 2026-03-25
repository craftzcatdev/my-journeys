//
//  FilmListView.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import SwiftUI

struct FilmListView: View {

    var filmViewModels = FilmsViewModel()

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
                    List(films) { film in
                        NavigationLink(value: film) {
                            FilmDetailScreen(film: film)
                        }
                    }
                    .navigationDestination(for: Film.self) { film in
                        Text(film.title)
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
    /// `@Previewable` là macro mới của `Swift` — cho phép dùng `@State` trực tiếp trong `#Preview` block mà không cần wrap vào một `View` phụ.
    @State @Previewable var vm = FilmsViewModel(service: MockGhiBliService())
    
    FilmListView(filmViewModels: vm)
}

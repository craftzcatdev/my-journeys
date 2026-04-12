//
//  FilmListView.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import SwiftUI

struct FilmListView: View {

    var films: [Film]

    var body: some View {
        
        List(films) { film in
            NavigationLink(value: film) {
                HStack {
                    FilmImageView(urlPath: film.image ?? "")
                        .frame(width: 100, height: 150)
                    Text(film.title)
                }
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(film: film)
            
        }
    }
}

//#Preview {
//    /// `@Previewable` là macro mới của `Swift` — cho phép dùng `@State` trực tiếp trong `#Preview` block mà không cần wrap vào một `View` phụ.
//    @State @Previewable var vm = FilmsViewModel(service: MockGhiBliService())
//    
//    FilmListView(filmViewModels: vm)
//}

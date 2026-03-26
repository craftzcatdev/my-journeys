//
//  FilmDetailScreen.swift
//  Ghibli
//
//  Created by Hai Ng. on 25/3/26.
//

import SwiftUI

struct FilmDetailScreen: View {
    
    let film: Film
    
    var body: some View {
        Text(film.title)
    }
}

#Preview {
    FilmDetailScreen(film: Film.example)
}

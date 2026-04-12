//
//  FavoritesScreen.swift
//  Ghibli
//
//  Created by Hai Ng. on 12/4/26.
//

import SwiftUI

struct FavoritesScreen: View {
    
    let filmsViewModel: FilmsViewModel

    var body: some View {
        Text("")
    }
}

#Preview {
    FavoritesScreen(
        filmsViewModel: FilmsViewModel(service: MockGhiBliService())
    )
}

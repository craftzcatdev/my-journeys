//
//  ContentView.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var filmsViewModel = FilmsViewModel()

    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen(filmsViewModel: filmsViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
               FavoritesScreen(filmsViewModel: filmsViewModel)
            }
            
            Tab("Setting", systemImage: "gear"){
                SettingScreen()
            }
            Tab(role: .search) {
                SearchScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}

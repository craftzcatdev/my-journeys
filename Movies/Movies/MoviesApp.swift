//
//  MoviesApp.swift
//  Movies
//
//  Created by Hai Ng. on 15/3/26.
//

import SwiftUI
import SwiftData

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
            }
        }
        .modelContainer(for: [Movie.self])
    }
}

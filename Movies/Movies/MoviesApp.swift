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
                AddMovieScreen()
            }
        }
        .modelContainer(for: [Movie.self])
    }
}

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
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Movie.self, migrationPlan: MoviesMigrationPlan.self, configurations: ModelConfiguration(for: Movie.self))
        } catch {
            fatalError("Couldn't initialize the container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
            }
        }
        .modelContainer(for: [Movie.self])
    }
}

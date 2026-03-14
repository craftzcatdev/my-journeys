//
//  WatchlistApp.swift
//  Watchlist
//
//  Created by Hai Ng. on 14/3/26.
//

import SwiftUI
import SwiftData

@main
struct WatchlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Movie.self)
        }
    }
}

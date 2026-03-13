//
//  WishlistApp.swift
//  Wishlist
//
//  Created by Hai Ng. on 13/3/26.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
